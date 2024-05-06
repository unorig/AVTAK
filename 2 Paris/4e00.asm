l_4E00
                    LDA V_MapXposition              ; (4E00) Load A with $033C
                    STA $AE                         ; (4E03) Store A to $AE
                    LDA V_MapYposition              ; (4E05) Load A with $033D
                    STA $AF                         ; (4E08) Store A to $AF
                    LDA $0335                       ; (4E0A) Load A with $0335
                    BEQ l_4E2E                      ; (4E0D) Branch to $4E2E if Equal
                    BMI l_4E21                      ; (4E0F) Branch to $4E21 if minus 
                    CLC                             ; (4E11) Clear Carry Flag
                    LDA #$7E                        ; (4E12) Set A to #$7E (126 / 01111110)
                    ADC $AE                         ; (4E14) Add with Carry $AE
                    STA $AE                         ; (4E16) Store A to $AE
                    LDA $AF                         ; (4E18) Load A with $AF
                    ADC #$00                        ; (4E1A) Add with Carry with #$00 (0 / 00000000)
                    STA $AF                         ; (4E1C) Store A to $AF
                    JMP l_4E2E                      ; (4E1E) Jump to $4E2E

l_4E21
                    SEC                             ; (4E21) Set Carry Flag
                    LDA $AE                         ; (4E22) Load A with $AE
                    SBC #$7E                        ; (4E24) Subtract with Carry #$7E (126 / 01111110)
                    STA $AE                         ; (4E26) Store A to $AE
                    LDA $AF                         ; (4E28) Load A with $AF
                    SBC #$00                        ; (4E2A) Subtract with Carry #$00 (0 / 00000000)
                    STA $AF                         ; (4E2C) Store A to $AF

l_4E2E
                    LDA $0334                       ; (4E2E) Load A with $0334
                    BEQ l_4E52                      ; (4E31) Branch to $4E52 if Equal
                    BMI l_4E45                      ; (4E33) Branch to $4E45 if minus 
                    CLC                             ; (4E35) Clear Carry Flag
                    LDA #$01                        ; (4E36) Set A to #$01 (1 / 00000001)
                    ADC $AE                         ; (4E38) Add with Carry $AE
                    STA $AE                         ; (4E3A) Store A to $AE
                    LDA $AF                         ; (4E3C) Load A with $AF
                    ADC #$00                        ; (4E3E) Add with Carry with #$00 (0 / 00000000)
                    STA $AF                         ; (4E40) Store A to $AF
                    JMP l_4E52                      ; (4E42) Jump to $4E52

l_4E45
                    SEC                             ; (4E45) Set Carry Flag
                    LDA $AE                         ; (4E46) Load A with $AE
                    SBC #$01                        ; (4E48) Subtract with Carry #$01 (1 / 00000001)
                    STA $AE                         ; (4E4A) Store A to $AE
                    LDA $AF                         ; (4E4C) Load A with $AF
                    SBC #$00                        ; (4E4E) Subtract with Carry #$00 (0 / 00000000)
                    STA $AF                         ; (4E50) Store A to $AF

l_4E52
                    CLC                             ; (4E52) Clear Carry Flag
                    LDA $AE                         ; (4E53) Load A with $AE
                    ADC #$08                        ; (4E55) Add with Carry with #$08 (8 / 00001000)
                    STA $AE                         ; (4E57) Store A to $AE
                    LDA $AF                         ; (4E59) Load A with $AF
                    ADC #$03                        ; (4E5B) Add with Carry with #$03 (3 / 00000011)
                    STA $AF                         ; (4E5D) Store A to $AF
                    SEC                             ; (4E5F) Set Carry Flag
                    LDA $AE                         ; (4E60) Load A with $AE
                    SBC $C9                         ; (4E62) Subtract with Carry $C9
                    TAX                             ; (4E64) Transfer A to X
                    LDA $AF                         ; (4E65) Load A with $AF
                    SBC $CA                         ; (4E67) Subtract with Carry $CA
                    STA $FE                         ; (4E69) Store A to $FE
                    LDY #$03                        ; (4E6B) Load Y with #$03 (3 / 00000011)

l_4E6D
                    LDA $FE                         ; (4E6D) Load A with $FE
                    CMP $4EC4,Y                     ; (4E6F) Compare Accumulator $4EC4,Y
                    BNE l_4E7A                      ; (4E72) Branch to $4E7A if Not Equal
                    TXA                             ; (4E74) Transfer X to A
                    CMP $4EC0,Y                     ; (4E75) Compare Accumulator $4EC0,Y
                    BEQ l_4E80                      ; (4E78) Branch to $4E80 if Equal

l_4E7A
                    DEY                             ; (4E7A) Decrement Y Register
                    BPL l_4E6D                      ; (4E7B) Branch to $4E6D if positive
                    JMP l_4E97                      ; (4E7D) Jump to $4E97

l_4E80
                    STY $02                         ; (4E80) Store Y Register $02
                    LDY #$00                        ; (4E82) Load Y with #$00 (0 / 00000000)
                    LDA ($C9),Y                     ; (4E84) Load A with ($C9),Y
                    CMP #$12                        ; (4E86) Subtract #$12 from A (18 / 00010010)
                    BCC l_4EA0                      ; (4E88) Branch to $4EA0 if Carry Clear
                    CMP #$1A                        ; (4E8A) Subtract #$1A from A (26 / 00011010)
                    BCS l_4EA0                      ; (4E8C) Branch if Carry Set $4EA0
                    LDY $02                         ; (4E8E) Load Y with Data from $02
                    LDA $4EC8,Y                     ; (4E90) Load A with $4EC8,Y
                    LDY #$00                        ; (4E93) Load Y with #$00 (0 / 00000000)
                    STA ($C9),Y                     ; (4E95) Store Accumulator ($C9),Y

l_4E97
                    LDA $AE                         ; (4E97) Load A with $AE
                    STA $C9                         ; (4E99) Store A to $C9
                    LDA $AF                         ; (4E9B) Load A with $AF
                    STA $CA                         ; (4E9D) Store A to $CA
                    RTS                             ; (4E9F) Return from Subroutine

l_4EA0
                    LDY $02                         ; (4EA0) Load Y with Data from $02
                    CMP $4ECC,Y                     ; (4EA2) Compare Accumulator $4ECC,Y
                    BEQ l_4E97                      ; (4EA5) Branch to $4E97 if Equal
                    LDX $03A2                       ; (4EA7) Load X with $03A2
                    INX                             ; (4EAA) Increment X
                    CPX #$14                        ; (4EAB) Subtract #$14 from X (20 / 00010100)
                    BNE l_4EB4                      ; (4EAD) Branch to $4EB4 if Not Equal
                    JSR l_4900                      ; (4EAF) Jump to Subroutine at $4900
                    LDX #$12                        ; (4EB2) Set X to #$12 (18 / 00010010)

l_4EB4
                    STX $03A2                       ; (4EB4) Store X Register $03A2
                    JMP l_4E97                      ; (4EB7) Jump to $4E97