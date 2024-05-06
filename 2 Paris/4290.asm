l_4290
                    LDX #$0F                        ; (4290) Set X to #$0F (15 / 00001111)

l_4292
                    LDA $6900,X                     ; (4292) Load A with $6900,X
                    SEC                             ; (4295) Set Carry Flag
                    SBC var_BondCarXPosLow          ; (4296) Subtract with Carry $0338
                    STA $AD                         ; (4299) Store A to $AD
                    LDA $6940,X                     ; (429B) Load A with $6940,X
                    SBC var_BondCarXPosHigh         ; (429E) Subtract with Carry $0339
                    STA $AF                         ; (42A1) Store A to $AF
                    BEQ l_42AF                      ; (42A3) Branch to $42AF if Equal. This determines the other sprite below distance of #100.
                    CMP #$01                        ; (42A5) Subtract #$01 from A (1 / 00000001)
                    BNE l_431E                      ; (42A7) Branch to $431E if Not Equal. This determines if the distance is above #1ff.
                    LDA $AD                         ; (42A9) Load A with $AD
                    CMP #$40                        ; (42AB) Subtract #$40 from A (64 / 01000000)
                    BCS l_431E                      ; (42AD) Branch if Carry Set $431E

l_42AF
                    LDA $6980,X                     ; (42AF) Load A with $6980,X
                    SEC                             ; (42B2) Set Carry Flag
                    SBC $033A                       ; (42B3) Subtract with Carry $033A
                    STA $FD                         ; (42B6) Store A to $FD
                    LDA $69C0,X                     ; (42B8) Load A with $69C0,X
                    SBC $033B                       ; (42BB) Subtract with Carry $033B
                    BNE l_431E                      ; (42BE) Branch to $431E if Not Equal
                    LDA $FD                         ; (42C0) Load A with $FD
                    CMP #$70                        ; (42C2) Subtract #$70 from A (112 / 01110000)
                    BCS l_431E                      ; (42C4) Branch if Carry Set $431E
                    LDA $6910,X                     ; (42C6) Load A with $6910,X
                    TAY                             ; (42C9) Transfer A to Y
                    BMI l_42E7                      ; (42CA) Branch to $42E7 if minus 
                    AND #$40                        ; (42CC) Logical AND with Accumulator and #$40 (64 / 01000000)
                    BNE l_4317                      ; (42CE) Branch to $4317 if Not Equal
                    TYA                             ; (42D0) Transfer Y to A
                    AND #$07                        ; (42D1) Logical AND with Accumulator and #$07 (7 / 00000111)
                    TAY                             ; (42D3) Transfer A to Y
                    LDA $03C8,Y                     ; (42D4) Load A with $03C8,Y
                    AND SpriteEnableRegister        ; (42D7) Logical AND with Accumulator $D015
                    BEQ l_42E7                      ; (42DA) Branch to $42E7 if Equal
                    LDA $6910,X                     ; (42DC) Load A with $6910,X
                    ORA #$40                        ; (42DF) Logical OR with Accumulator and #$40 (64 / 01000000)
                    STA $6910,X                     ; (42E1) Store A to $6910,X
                    JMP l_4317                      ; (42E4) Jump to $4317

l_42E7
                    LDA $6910,X                     ; (42E7) Load A with $6910,X
                    ORA #$80                        ; (42EA) Logical OR with Accumulator and #$80 (128 / 10000000)
                    STA $6910,X                     ; (42EC) Store A to $6910,X
                    AND #$07                        ; (42EF) Logical AND with Accumulator and #$07 (7 / 00000111)
                    STA $02                         ; (42F1) Store A to $02
                    INC $02                         ; (42F3) Increment Memory $02
                    LDA SpritePointerArray,X                     ; (42F5) Load A with $6920,X
                    STA $AE                         ; (42F8) Store A to $AE
                    TXA                             ; (42FA) Transfer X to A
                    PHA                             ; (42FB) Push Accumulator to Stack
                    LDA $FD                         ; (42FC) Load A with $FD
                    CLC                             ; (42FE) Clear Carry Flag
                    ADC #$90                        ; (42FF) Add with Carry with #$90 (144 / 10010000)
                    TAY                             ; (4301) Transfer A to Y
                    CLC                             ; (4302) Clear Carry Flag
                    LDA $AD                         ; (4303) Load A with $AD
                    ADC #$07                        ; (4305) Add with Carry with #$07 (7 / 00000111)
                    TAX                             ; (4307) Transfer A to X
                    LDA $AF                         ; (4308) Load A with $AF
                    ADC #$00                        ; (430A) Add with Carry with #$00 (0 / 00000000)
                    CLC                             ; (430C) Clear Carry Flag
                    BEQ l_4310                      ; (430D) Branch to $4310 if Equal
                    SEC                             ; (430F) Set Carry Flag

l_4310
                    LDA $02                         ; (4310) Load A with $02
                    JSR l_4200                      ; (4312) Jump to Subroutine at $4200
                    PLA                             ; (4315) Pull Accumulator from Stack
                    TAX                             ; (4316) Transfer A to X

l_4317
                    DEX                             ; (4317) Decrement X
                    BMI l_431D                      ; (4318) Branch to $431D if minus 
                    JMP l_4292                      ; (431A) Jump to $4292

l_431D
                    RTS                             ; (431D) Return from Subroutine

l_431E
                    LDA $6910,X                     ; (431E) Load A with $6910,X
                    TAY                             ; (4321) Transfer A to Y
                    BMI l_4357                      ; (4322) Branch to $4357 if minus 

l_4324
                    AND #$10                        ; (4324) Logical AND with Accumulator and #$10 (16 / 00010000)
                    BNE l_4330                      ; (4326) Branch to $4330 if Not Equal
                    JMP l_4375                      ; (4328) Jump to $4375

* = $432B
            .byte $EA,$EA,$EA,$EA,$EA

* = $4330

l_4330
                    LDA $6800,X                     ; (4330) Load A with $6800,X
                    STA $6900,X               ; (4333) Store A to $6900,X
                    LDA $6840,X                     ; (4336) Load A with $6840,X
                    STA $6940,X                     ; (4339) Store A to $6940,X
                    LDA $6880,X                     ; (433C) Load A with $6880,X
                    STA $6980,X                ; (433F) Store A to $6980,X
                    LDA $68C0,X                     ; (4342) Load A with $68C0,X
                    STA $69C0,X                     ; (4345) Store A to $69C0,X
                    LDA $6820,X                     ; (4348) Load A with $6820,X
                    STA SpritePointerArray,X                     ; (434B) Store A to $6920,X
                    LDA $6830,X                     ; (434E) Load A with $6830,X
                    STA MaydayDirection,X           ; (4351) Store A to $6930,X
                    JMP l_4375                      ; (4354) Jump to $4375

l_4357
                    LDA $6910,X                     ; (4357) Load A with $6910,X
                    AND #$07                        ; (435A) Logical AND with Accumulator and #$07 (7 / 00000111)
                    TAY                             ; (435C) Transfer A to Y
                    LDA $03C0,Y                     ; (435D) Load A with $03C0,Y
                    AND SpriteEnableRegister        ; (4360) Logical AND with Accumulator $D015
                    STA SpriteEnableRegister        ; (4363) Store A to $D015
                    LDA $03C0,Y                     ; (4366) Load A with $03C0,Y
                    AND SpriteMulticolor            ; (4369) Logical AND with Accumulator $D01C
                    STA SpriteMulticolor            ; (436C) Store A to $D01C
                    LDA $6910,Y                     ; (436F) Load A with $6910,Y
                    JMP l_4324                      ; (4372) Jump to $4324

l_4375
                    LDA $6910,X                     ; (4375) Load A with $6910,X
                    AND #$07                        ; (4378) Logical AND with Accumulator and #$07 (7 / 00000111)
                    STA $6910,X                     ; (437A) Store A to $6910,X
                    JMP l_4317                      ; (437D) Jump to $4317