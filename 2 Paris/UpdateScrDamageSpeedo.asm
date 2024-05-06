Sub_UpdateScrDamageSpeedo
                    LDA CarSpeed                    ; (4500) Load A with $0340
                    LSR A                           ; (4503) Logical Shift Right Accumulator
                    AND #$03                        ; (4504) Logical AND with Accumulator and #$03 (3 / 00000011)
                    CLC                             ; (4506) Clear Carry Flag
                    ADC #$00                        ; (4507) Add with Carry with #$00 (0 / 00000000)
                    PHA                             ; (4509) Push Accumulator to Stack
                    LDY #$07                        ; (450A) Load Y with #$07 (7 / 00000111)
                    LDA #$04                        ; (450C) Set A to #$04 (4 / 00000100). The value to be entered into the 8 bits at $0576-$057x

l_UpdateScrSpeedo
                    STA $0576,Y                     ; (450E) Set $0576,Y to A
                    DEY                             ; (4511) Decrement Y
                    BPL l_UpdateScrSpeedo           ; (4512) Loop 8 times.
                    LDA CarSpeed                    ; (4514) Load A with $0340
                    CLC                             ; (4517) Clear Carry Flag
                    LSR A                           ; (4518) Logical Shift Right Accumulator
                    LSR A                           ; (4519) Logical Shift Right Accumulator
                    LSR A                           ; (451A) Divide carspeed by 8.
                    STA $02                         ; (451B) Store carspeed / 8 to $02
                    LDA #$07                        ; (451D) Set A to #$07 (7 / 00000111)
                    SEC                             ; (451F) Set Carry Flag
                    SBC $02                         ; (4520) Subtract with Carry $02
                    TAY                             ; (4522) Transfer A to Y
                    PLA                             ; (4523) Pull Accumulator from Stack
                    STA $0576,Y                     ; (4524) Set $0576,Y to A
                    JMP l_UpdateScrDamageBar        ; (4527) Jump to $4530

* = $452A
            .byte $EA,$EA,$EA,$EA,$EA,$EA

* = $4530

l_UpdateScrDamageBar
                    LDA DamageCount                 ; (4530) Load A with $03A1
                    LSR A                           ; (4533) Logical Shift Right Accumulator
                    LSR A                           ; (4534) Logical Shift Right Accumulator
                    LSR A                           ; (4535) Logical Shift Right Accumulator
                    TAY                             ; (4536) Transfer A to Y
                    LDA DamageCount                 ; (4537) Load A with $03A1. Maximum is #28 (40 / 00101000)
                    AND #$07                        ; (453A) Logical AND with Accumulator and #$07 (7 / 00000111). Get values from 0-7 which is added to #c4.
                    CLC                             ; (453C) Clear Carry Flag
                    ADC #$C4                        ; (453D) Add with Carry with #$C4 (196 / 11000100). #c4 is the default value for the section of the damage bar.
                    TAX                             ; (453F) Transfer A to X. This will be the value for the damage meter piece.
                    LDA $4550,Y                     ; (4540) Load A with $4550,Y
                    STA $AE                         ; (4543) Store A to $AE
                    LDA $4558,Y                     ; (4545) Load A with $4558,Y
                    STA $AF                         ; (4548) Store A to $AF
                    LDY #$00                        ; (454A) Load Y with #$00 (0 / 00000000)
                    TXA                             ; (454C) Transfer X to A. Get the character for the damage bar which was calculated previously.
                    STA ($AE),Y                     ; (454D) Update part of the damage bar.
                    RTS                             ; (454F) Return from Subroutine