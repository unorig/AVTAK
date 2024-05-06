Sub_MaydayAndClock
                    LDA EndGameFlag                 ; (5200) Load $0313. #00 Continue / #80 Mayday found / Ends game #27.
                    BNE _rts                        ; (5203) Branch to $5216 if game is ending. This will RTS.
                    LDY MaydayLoopCounter           ; (5205) Load MaydayLoopCounter. Loops from 7 to 0.
                    DEY                             ; (5208) Decrement MaydayLoopCounter
                    STY MaydayLoopCounter           ; (5209) Store MaydayLoopCounter
                    BNE _rts                        ; (520C) Branch to $5216 if Not zero. This will RTS as Mayday is continuing in the same direction.
                    LDA MaydayLanded                ; (520E) Load A with $02FE. #00 continue circling / #01 Landed.
                    BEQ l_5218                      ; (5211) Branch to $5218 if Equal. Mayday is continuing to circle.
                    JMP l_52A4                      ; (5213) Jump to $52A4. Mayday has landed.

_rts
                    RTS                             ; (5216) Return from Subroutine

* = $5217
            .byte $60

* = $5218

l_5218
                    LDY #$07                        ; (5218) Load Y with #$07 (7 / 00000111).
                    STY MaydayLoopCounter           ; (521A) Reset loop counter to #07 ($034F).
                    LDA MaydayDirection             ; (521D) Load A with $6930. 7:NW, 6:W, 5:SW, 4:W, 3:SE, 2:E, 1:NE, 0:N. 
                    TAY                             ; (5220) Transfer A to Y
                    LDA $69B0,Y                     ; (5221) Load A with $69B0,Y. $69B0 (N:Zero), $69B1 (NE:One), $69B2 (E:One), $69B3 (SE:One), $69B4 (S:Zero), $69B5 (SW:Neg), $69B6 (W:Neg), $69B7 (NW:Neg)
                    BMI ReduceMaydayX               ; (5224) Branch to $5239 if minus. Going west so reduce X.
                    BEQ MaydayNorthOrSouth          ; (5226) Branch to $5247 if Equal. Going north or south branch to MaydayNorthOrSouth.
                    CLC                             ; (5228) Clear Carry Flag
                    LDA MaydayXMap                  ; (5229) Load A with $6900
                    ADC #$01                        ; (522C) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayXMap                  ; (522E) Store A to $6900
                    BCC MaydayNorthOrSouth          ; (5231) Branch to $5247 if Carry Clear
                    INC $6940                       ; (5233) Increment Memory $6940
                    JMP MaydayNorthOrSouth          ; (5236) Jump to $5247

ReduceMaydayX
                    SEC                             ; (5239) Set Carry Flag
                    LDA MaydayXMap                  ; (523A) Load A with $6900
                    SBC #$01                        ; (523D) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayXMap                  ; (523F) Store A to $6900
                    BCS MaydayNorthOrSouth          ; (5242) Branch if Carry Set $5247
                    DEC $6940                       ; (5244) Decrement $6940

MaydayNorthOrSouth
                    LDA $69B8,Y                     ; (5247) Load A with $69B8,Y. $69B8 (N:Neg), $69B9 (NE:Neg), $69BA (E:Zero), $69BB (SE:One), $69BC (S:One), $69BD (SW:One), $69BE (W:Zero), $69BF (NW:Neg)
                    BMI ReduceMaydayY               ; (524A) Branch to $525F if minus / Going any North direction. 
                    BEQ MaydayEastOrWest            ; (524C) Branch to $526D if Equal / Going East or West.
                    CLC                             ; (524E) Clear Carry Flag
                    LDA MaydayYMap                  ; (524F) Load A with $6980
                    ADC #$01                        ; (5252) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayYMap                  ; (5254) Store A to $6980
                    BCC MaydayEastOrWest            ; (5257) Branch to $526D if Carry Clear
                    INC $69C0                       ; (5259) Increment Memory $69C0
                    JMP MaydayEastOrWest            ; (525C) Jump to $526D

ReduceMaydayY
                    SEC                             ; (525F) Set Carry Flag
                    LDA MaydayYMap                  ; (5260) Load A with $6980
                    SBC #$01                        ; (5263) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayYMap                  ; (5265) Store A to $6980
                    BCS MaydayEastOrWest            ; (5268) Branch if Carry Set $526D
                    DEC $69C0                       ; (526A) Decrement $69C0

MaydayEastOrWest
                    LDA MaydaySPArray,Y             ; (526D) Load A with $03E0,Y. 
                    STA SpritePointerArray          ; (5270) Store A to $6920
                    LDY MaydayPathCounter           ; (5273) Load Y with Data from $69F8
                    DEY                             ; (5276) Decrement Y Register
                    STY MaydayPathCounter           ; (5277) Store Y Register $69F8
                    BNE l_52A1                      ; (527A) Branch to $52A1 if Not Equal
                    CLC                             ; (527C) Clear Carry Flag
                    LDA MaydayTurnsTaken            ; (527D) Load A with $69F9
                    ADC #$02                        ; (5280) Add with Carry with #$02 (2 / 00000010)
                    STA MaydayTurnsTaken            ; (5282) Store A to $69F9
                    NOP                             ; (5285) No operation
                    CMP MayDayLandLocation          ; (5286) Subtract $D3 from A. Compare number of Mayday turns taken against $D3.
                    BNE l_5290                      ; (5288) Branch to $5290 if Not Equal
                    INC MaydayLanded                ; (528A) Increment Memory $02FE. #00 continue circling / #01 Landed.
                    JMP UpdateMaydayDirection       ; (528D) Jump to $5296

l_5290
                    LDY MaydayTurnsTaken            ; (5290) Load Y with Data from $69F9
                    STY MaydayPathCounter           ; (5293) Store Y Register $69F8

UpdateMaydayDirection
                    LDY MaydayDirection             ; (5296) Load Y with Data from $6930
                    DEY                             ; (5299) Decrement Y Register
                    BPL StoreMaydayDirection        ; (529A) Branch to $529E if positive
                    LDY #$07                        ; (529C) Load Y with #$07 (7 / 00000111)

StoreMaydayDirection
                    STY MaydayDirection             ; (529E) Store Y Register $6930

l_52A1
                    JMP l_5315                      ; (52A1) Jump to $5315

l_52A4
                    LDY #$08                        ; (52A4) Load Y with #$08 (8 / 00001000)
                    STY MaydayLoopCounter           ; (52A6) Store Y Register $034F
                    LDA $6940                       ; (52A9) Load A with $6940
                    CMP $69FD                       ; (52AC) Subtract $69FD from A
                    BCC l_52D1                      ; (52AF) Branch to $52D1 if Carry Clear
                    BEQ l_52B6                      ; (52B1) Branch to $52B6 if Equal
                    JMP l_52C0                      ; (52B3) Jump to $52C0

l_52B6
                    LDA MaydayXMap                  ; (52B6) Load A with $6900
                    CMP $69FC                       ; (52B9) Subtract $69FC from A
                    BCC l_52D1                      ; (52BC) Branch to $52D1 if Carry Clear
                    BEQ l_52DF                      ; (52BE) Branch to $52DF if Equal

l_52C0
                    SEC                             ; (52C0) Set Carry Flag
                    LDA MaydayXMap                  ; (52C1) Load A with $6900
                    SBC #$01                        ; (52C4) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayXMap                  ; (52C6) Store A to $6900
                    BCS l_52DF                      ; (52C9) Branch if Carry Set $52DF
                    DEC $6940                       ; (52CB) Decrement $6940
                    JMP l_52DF                      ; (52CE) Jump to $52DF

l_52D1
                    CLC                             ; (52D1) Clear Carry Flag
                    LDA MaydayXMap                  ; (52D2) Load A with $6900
                    ADC #$01                        ; (52D5) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayXMap                  ; (52D7) Store A to $6900
                    BCC l_52DF                      ; (52DA) Branch to $52DF if Carry Clear
                    INC $6940                       ; (52DC) Increment Memory $6940

l_52DF
                    LDA $69C0                       ; (52DF) Load A with $69C0
                    CMP $69FF                       ; (52E2) Subtract $69FF from A
                    BCC l_5307                      ; (52E5) Branch to $5307 if Carry Clear
                    BEQ l_52EC                      ; (52E7) Branch to $52EC if Equal
                    JMP l_52F6                      ; (52E9) Jump to $52F6

l_52EC
                    LDA MaydayYMap                  ; (52EC) Load A with $6980
                    CMP $69FE                       ; (52EF) Subtract $69FE from A
                    BCC l_5307                      ; (52F2) Branch to $5307 if Carry Clear
                    BEQ l_5315                      ; (52F4) Branch to $5315 if Equal

l_52F6
                    SEC                             ; (52F6) Set Carry Flag
                    LDA MaydayYMap                  ; (52F7) Load A with $6980
                    SBC #$01                        ; (52FA) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayYMap                  ; (52FC) Store A to $6980
                    BCS l_5315                      ; (52FF) Branch if Carry Set $5315
                    DEC $69C0                       ; (5301) Decrement $69C0
                    JMP l_5315                      ; (5304) Jump to $5315

l_5307
                    CLC                             ; (5307) Clear Carry Flag
                    LDA MaydayYMap                  ; (5308) Load A with $6980
                    ADC #$01                        ; (530B) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayYMap                  ; (530D) Store A to $6980
                    BCC l_5315                      ; (5310) Branch to $5315 if Carry Clear
                    INC $69C0                       ; (5312) Increment Memory $69C0

l_5315
                    LDX $535C                       ; (5315) Load X with $535C
                    DEX                             ; (5318) Decrement X
                    STX $535C                       ; (5319) Store X Register $535C
                    BNE l_534D_RTS                  ; (531C) Branch to $534D if Not Equal
                    LDX #$14                        ; (531E) Set X to #$14 (20 / 00010100)
                    STX $535C                       ; (5320) Store X Register $535C
                    NOP                             ; (5323) No operation.
                    LDX #$02                        ; (5324) Set X to #$02 (2 / 00000010). Used to select three timer values.

ReduceTimer
                    DEC ScrCounterDigit100,X        ; (5326) Decrement $04F3,X. #6d:9,#6c:8,#6b:7,#6a:6,#69:5,#68:4,#67:3,#66:2,#65:1,#64:0.
                    LDA ScrCounterDigit100,X        ; (5329) Load A with $04F3,X
                    CMP #$63                        ; (532C) Subtract #$63 from A (99 / 01100011)
                    BNE CheckRemainingTime          ; (532E) Branch to $5338 if Not Equal
                    LDA #$6D                        ; (5330) Set A to #$6D (109 / 01101101)
                    STA ScrCounterDigit100,X        ; (5332) Store A to $04F3,X
                    DEX                             ; (5335) Decrement X
                    BPL ReduceTimer                 ; (5336) Branch to $5326 if positive

CheckRemainingTime
                    LDA ScrCounterDigit100          ; (5338) Load A with $04F3
                    CMP #$64                        ; (533B) Subtract #$64 from A (100 / 01100100). #64 represents zero on clock.
                    BNE l_534D_RTS                  ; (533D) Branch to $534D if Not Equal.
                    LDA ScrCounterDigit10           ; (533F) Load A with $04F4
                    CMP #$64                        ; (5342) Subtract #$64 from A (100 / 01100100). #64 represents zero on clock.
                    BNE Check60SecLeft              ; (5344) Branch to $534E if Not Equal
                    LDA ScrCounterDigit1            ; (5346) Load A with $04F5
                    CMP #$64                        ; (5349) Subtract #$64 from A (100 / 01100100). #64 represents zero on clock.
                    BEQ ClockRanOut                 ; (534B) Branch to $5356 if Equal. Branch if clock reaches 000.

l_534D_RTS
                    RTS                             ; (534D) Return from Subroutine

Check60SecLeft
                    CMP #$6A                        ; (534E) Subtract #$6A from A (106 / 01101010)
                    BCS l_5355_RTS                  ; (5350) Branch if Carry Set $5355
                    INC MaydayBeginLanding          ; (5352) Increment Memory $02E1

l_5355_RTS
                    RTS                             ; (5355) Return from Subroutine

ClockRanOut
                    LDA #$40                        ; (5356) Set A to #$40 (64 / 01000000)
                    STA EndGameFlag                 ; (5358) Store A to $0313. #00 Continue / #80 Mayday found / Ends game #27 / Clock ran out #40.
                    RTS                             ; (535B) Return from Subroutine