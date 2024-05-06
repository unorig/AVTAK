l_4C00
                    LDX #$0F                        ; (4C00) Set X to #$0F (15 / 00001111)
                    STX $AC                         ; (4C02) Store X to $AC
                    JMP l_4CB2                      ; (4C04) Jump to $4CB2

l_4C07
                    LDX $AC                         ; (4C07) Load X with $AC
                    LDA $6910,X                     ; (4C09) Load A with $6910,X
                    AND #$80                        ; (4C0C) Logical AND with Accumulator and #$80 (128 / 10000000)
                    BNE l_4C13                      ; (4C0E) Branch to $4C13 if Not Equal
                    JMP l_4D0C                      ; (4C10) Jump to $4D0C

l_4C13
                    LDA $6910,X                     ; (4C13) Load A with $6910,X
                    AND #$03                        ; (4C16) Logical AND with Accumulator and #$03 (3 / 00000011)
                    TAY                             ; (4C18) Transfer A to Y
                    LDA $03C8,Y                     ; (4C19) Load A with $03C8,Y
                    AND $02FC                       ; (4C1C) Logical AND with Accumulator $02FC
                    BEQ l_4C24                      ; (4C1F) Branch to $4C24 if Equal
                    JMP l_4D74                      ; (4C21) Jump to $4D74

l_4C24
                    LDA $6910,X                     ; (4C24) Load A with $6910,X
                    AND #$20                        ; (4C27) Logical AND with Accumulator and #$20 (32 / 00100000)
                    BEQ l_4C2E                      ; (4C29) Branch to $4C2E if Equal
                    JMP l_4D33                      ; (4C2B) Jump to $4D33

l_4C2E
                    LDA $6910,X                     ; (4C2E) Load A with $6910,X
                    AND #$03                        ; (4C31) Logical AND with Accumulator and #$03 (3 / 00000011)
                    TAY                             ; (4C33) Transfer A to Y
                    LDA $03A2                       ; (4C34) Load A with $03A2
                    CMP $69E0,X                     ; (4C37) Subtract $69E0,X from A
                    BCS l_4C3F                      ; (4C3A) Branch if Carry Set $4C3F
                    JMP l_4D0C                      ; (4C3C) Jump to $4D0C

l_4C3F
                    LDA CarCollision                       ; (4C3F) Load A with $02FD
                    AND $03C8,Y                     ; (4C42) Logical AND with Accumulator $03C8,Y
                    BEQ l_4C4F                      ; (4C45) Branch to $4C4F if Equal
                    LDA #$C0                        ; (4C47) Set A to #$C0 (192 / 11000000)
                    STA $6950,X                     ; (4C49) Store A to $6950,X
                    JMP l_4D0C                      ; (4C4C) Jump to $4D0C

l_4C4F
                    DEC $6950,X                     ; (4C4F) Decrement $6950,X
                    LDA $6950,X                     ; (4C52) Load A with $6950,X
                    BEQ l_4C5A                      ; (4C55) Branch to $4C5A if Equal
                    JMP l_4D0C                      ; (4C57) Jump to $4D0C

l_4C5A
                    LDA $6960,X                     ; (4C5A) Load A with $6960,X
                    STA $6950,X                     ; (4C5D) Store A to $6950,X
                    LDA MaydayYMap,X                ; (4C60) Load A with $6980,X
                    LDY $69C0,X                     ; (4C63) Load Index Register Y $69C0,X
                    LDX #$08                        ; (4C66) Set X to #$08 (8 / 00001000)
                    JSR l_4AB0                      ; (4C68) Jump to Subroutine at $4AB0
                    LDA $FD                         ; (4C6B) Load A with $FD
                    LDX #$7E                        ; (4C6D) Set X to #$7E (126 / 01111110)
                    JSR l_4D17                      ; (4C6F) Jump to Subroutine at $4D17
                    STA $FC                         ; (4C72) Store A to $FC
                    STX $FB                         ; (4C74) Store X to $FB
                    LDX $AC                         ; (4C76) Load X with $AC
                    LDA MaydayXMap,X                ; (4C78) Load A with $6900,X
                    LDY $6940,X                     ; (4C7B) Load Index Register Y $6940,X
                    LDX #$08                        ; (4C7E) Set X to #$08 (8 / 00001000)
                    JSR l_4AB0                      ; (4C80) Jump to Subroutine at $4AB0
                    CLC                             ; (4C83) Clear Carry Flag
                    LDA $FB                         ; (4C84) Load A with $FB
                    ADC $FD                         ; (4C86) Add with Carry $FD
                    STA $FB                         ; (4C88) Store A to $FB
                    LDA $FC                         ; (4C8A) Load A with $FC
                    ADC #$00                        ; (4C8C) Add with Carry with #$00 (0 / 00000000)
                    STA $FC                         ; (4C8E) Store A to $FC
                    CLC                             ; (4C90) Clear Carry Flag
                    LDA $FB                         ; (4C91) Load A with $FB
                    ADC #$72                        ; (4C93) Add with Carry with #$72 (114 / 01110010)
                    STA $FB                         ; (4C95) Store A to $FB
                    LDA $FC                         ; (4C97) Load A with $FC
                    ADC #$93                        ; (4C99) Add with Carry with #$93 (147 / 10010011)
                    STA $FC                         ; (4C9B) Store A to $FC
                    LDY #$00                        ; (4C9D) Load Y with #$00 (0 / 00000000)
                    LDA ($FB),Y                     ; (4C9F) Load A with ($FB),Y
                    CMP #$12                        ; (4CA1) Subtract #$12 from A (18 / 00010010)
                    BCC l_4CB0                      ; (4CA3) Branch to $4CB0 if Carry Clear
                    CMP #$1A                        ; (4CA5) Subtract #$1A from A (26 / 00011010)
                    BCS l_4CB0                      ; (4CA7) Branch if Carry Set $4CB0
                    AND #$07                        ; (4CA9) Logical AND with Accumulator and #$07 (7 / 00000111)
                    LDX $AC                         ; (4CAB) Load X with $AC
                    STA MaydayDirection,X           ; (4CAD) Store A to $6930,X

l_4CB0
                    LDX $AC                         ; (4CB0) Load X with $AC

l_4CB2
                    LDA MaydayDirection,X           ; (4CB2) Load A with $6930,X
                    TAY                             ; (4CB5) Transfer A to Y
                    LDA $69B0,Y                     ; (4CB6) Load A with $69B0,Y
                    BMI l_4CCE                      ; (4CB9) Branch to $4CCE if minus 
                    BEQ l_4CDC                      ; (4CBB) Branch to $4CDC if Equal
                    CLC                             ; (4CBD) Clear Carry Flag
                    LDA MaydayXMap,X                ; (4CBE) Load A with $6900,X
                    ADC #$01                        ; (4CC1) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayXMap,X                ; (4CC3) Store A to $6900,X
                    BCC l_4CDC                      ; (4CC6) Branch to $4CDC if Carry Clear
                    INC $6940,X                     ; (4CC8) Increment Memory $6940,X
                    JMP l_4CDC                      ; (4CCB) Jump to $4CDC

l_4CCE
                    SEC                             ; (4CCE) Set Carry Flag
                    LDA MaydayXMap,X                ; (4CCF) Load A with $6900,X
                    SBC #$01                        ; (4CD2) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayXMap,X                ; (4CD4) Store A to $6900,X
                    BCS l_4CDC                      ; (4CD7) Branch if Carry Set $4CDC
                    DEC $6940,X                     ; (4CD9) Decrement $6940,X

l_4CDC
                    LDA $69B8,Y                     ; (4CDC) Load A with $69B8,Y
                    BMI l_4CF4                      ; (4CDF) Branch to $4CF4 if minus 
                    BEQ l_4D02                      ; (4CE1) Branch to $4D02 if Equal
                    CLC                             ; (4CE3) Clear Carry Flag
                    LDA MaydayYMap,X                ; (4CE4) Load A with $6980,X
                    ADC #$01                        ; (4CE7) Add with Carry with #$01 (1 / 00000001)
                    STA MaydayYMap,X                ; (4CE9) Store A to $6980,X
                    BCC l_4D02                      ; (4CEC) Branch to $4D02 if Carry Clear
                    INC $69C0,X                     ; (4CEE) Increment Memory $69C0,X
                    JMP l_4D02                      ; (4CF1) Jump to $4D02

l_4CF4
                    SEC                             ; (4CF4) Set Carry Flag
                    LDA MaydayYMap,X                ; (4CF5) Load A with $6980,X
                    SBC #$01                        ; (4CF8) Subtract with Carry #$01 (1 / 00000001)
                    STA MaydayYMap,X                ; (4CFA) Store A to $6980,X
                    BCS l_4D02                      ; (4CFD) Branch if Carry Set $4D02
                    DEC $69C0,X                     ; (4CFF) Decrement $69C0,X

l_4D02
                    CPX #$0F                        ; (4D02) Subtract #$0F from X (15 / 00001111)
                    BEQ l_4D0C                      ; (4D04) Branch to $4D0C if Equal
                    LDA $69A0,Y                     ; (4D06) Load A with $69A0,Y
                    STA SpritePointerArray,X                     ; (4D09) Store A to $6920,X

l_4D0C
                    LDX $AC                         ; (4D0C) Load X with $AC
                    DEX                             ; (4D0E) Decrement X
                    BEQ l_4D16                      ; (4D0F) Branch to $4D16 if Equal
                    STX $AC                         ; (4D11) Store X to $AC
                    JMP l_4C07                      ; (4D13) Jump to $4C07

l_4D16
                    RTS                             ; (4D16) Return from Subroutine

l_4D17
                    STA $FE                         ; (4D17) Store A to $FE
                    LDA #$00                        ; (4D19) Set A to #$00 (0 / 00000000)
                    STA $FD                         ; (4D1B) Store A to $FD
                    STX $02                         ; (4D1D) Store X to $02
                    LDX #$08                        ; (4D1F) Set X to #$08 (8 / 00001000)

l_4D21
                    LSR $02                         ; (4D21) Logical Shift Right $02
                    BCC l_4D28                      ; (4D23) Branch to $4D28 if Carry Clear
                    CLC                             ; (4D25) Clear Carry Flag
                    ADC $FE                         ; (4D26) Add with Carry $FE

l_4D28
                    ROR A                           ; (4D28) Rotate Right Accumulator
                    ROR $FD                         ; (4D29) Rotate Right $FD
                    DEX                             ; (4D2B) Decrement X
                    BNE l_4D21                      ; (4D2C) Branch to $4D21 if Not Equal
                    STA $FE                         ; (4D2E) Store A to $FE
                    LDX $FD                         ; (4D30) Load X with $FD
                    RTS                             ; (4D32) Return from Subroutine

l_4D33
                    DEC $6990,X                     ; (4D33) Decrement $6990,X
                    BEQ l_4D3B                      ; (4D36) Branch to $4D3B if Equal
                    JMP l_4D0C                      ; (4D38) Jump to $4D0C

l_4D3B
                    LDA #$18                        ; (4D3B) Set A to #$18 (24 / 00011000)
                    STA $6990,X                     ; (4D3D) Store A to $6990,X
                    DEC $6970,X                     ; (4D40) Decrement $6970,X
                    BEQ l_4D53                      ; (4D43) Branch to $4D53 if Equal
                    LDA $6970,X                     ; (4D45) Load A with $6970,X
                    AND #$01                        ; (4D48) Logical AND with Accumulator and #$01 (1 / 00000001)
                    CLC                             ; (4D4A) Clear Carry Flag
                    ADC #$AD                        ; (4D4B) Add with Carry with #$AD (173 / 10101101)
                    STA SpritePointerArray,X       ; (4D4D) Store A to $6920,X
                    JMP l_4D0C                      ; (4D50) Jump to $4D0C

l_4D53
                    LDA $6910,X                     ; (4D53) Load A with $6910,X
                    AND #$07                        ; (4D56) Logical AND with Accumulator and #$07 (7 / 00000111)
                    TAY                             ; (4D58) Transfer A to Y
                    LDA $03C0,Y                     ; (4D59) Load A with $03C0,Y
                    AND SpriteEnableRegister        ; (4D5C) Logical AND with Accumulator $D015
                    STA SpriteEnableRegister        ; (4D5F) Store A to $D015
                    LDA $03C0,Y                     ; (4D62) Load A with $03C0,Y
                    AND SpriteMulticolor            ; (4D65) Logical AND with Accumulator $D01C
                    STA SpriteMulticolor            ; (4D68) Store A to $D01C
                    TYA                             ; (4D6B) Transfer Y to A
                    ORA #$50                        ; (4D6C) Logical OR with Accumulator and #$50 (80 / 01010000)
                    STA $6910,X                     ; (4D6E) Store A to $6910,X
                    JMP l_4D0C                      ; (4D71) Jump to $4D0C

l_4D74
                    ORA SpriteMulticolor            ; (4D74) Logical OR with Accumulator and $D01C
                    STA SpriteMulticolor            ; (4D77) Store A to $D01C
                    LDA #$00                        ; (4D7A) Set A to #$00 (0 / 00000000)
                    STA $02FC                       ; (4D7C) Store A to $02FC
                    LDA $6910,X                     ; (4D7F) Load A with $6910,X
                    ORA #$70                        ; (4D82) Logical OR with Accumulator and #$70 (112 / 01110000)
                    STA $6910,X                     ; (4D84) Store A to $6910,X
                    LDA #$10                        ; (4D87) Set A to #$10 (16 / 00010000)
                    STA $6970,X                     ; (4D89) Store A to $6970,X
                    JSR l_4428                      ; (4D8C) Jump to Subroutine at $4428
                    JMP l_4D0C                      ; (4D8F) Jump to $4D0C

l_4D92
                    JSR l_4C00                      ; (4D92) Jump to Subroutine at $4C00
                    LDA #$00                        ; (4D95) Set A to #$00 (0 / 00000000)
                    STA CarCollision                ; (4D97) Store A to $02FD
                    STA $02FC                       ; (4D9A) Store A to $02FC
                    RTS                             ; (4D9D) Return from Subroutine