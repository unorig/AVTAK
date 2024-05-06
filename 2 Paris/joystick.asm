CheckJoyInputs
                    LDY #$00                        ; (4260) Load Y with #$00 (0 / 00000000)
                    LDX #$00                        ; (4262) Set X to #$00 (0 / 00000000)
                    SEC                             ; (4264) Set Carry Flag
                    LDA $0346                       ; (4265) Load A with $0346
                    BNE StoreJoyInputs              ; (4268) Branch to $427F if Not Equal
                    LDA KeyJoy2                     ; (426A) Load A with $DC00
                    NOP                             ; (426D) No operation
                    LSR A                           ; (426E) Logical Shift Right Accumulator
                    BCS CheckJoyDown                ; (426F) Branch if Carry Set $4272
                    DEY                             ; (4271) Decrement Y Register

CheckJoyDown
                    LSR A                           ; (4272) Logical Shift Right Accumulator
                    BCS CheckJoyLeft                ; (4273) Branch if Carry Set $4276
                    INY                             ; (4275) Increment Y Register. Down on joystick is detected.

CheckJoyLeft
                    LSR A                           ; (4276) Logical Shift Right Accumulator
                    BCS CheckJoyRight               ; (4277) Branch if Carry Set $427A
                    DEX                             ; (4279) Decrement X

CheckJoyRight
                    LSR A                           ; (427A) Logical Shift Right Accumulator
                    BCS JoyUp                       ; (427B) Branch if Carry Set $427E
                    INX                             ; (427D) Increment X

JoyUp
                    LSR A                           ; (427E) Logical Shift Right Accumulator

StoreJoyInputs
                    STX $FE                         ; (427F) Store X to $FE
                    STY $FD                         ; (4281) Store Y Register $FD
                    LDX #$00                        ; (4283) Set X to #$00 (0 / 00000000)
                    BCS StoreFireInputs             ; (4285) Branch if Carry Set $4288
                    INX                             ; (4287) Increment X

StoreFireInputs
                    STX $02                         ; (4288) Store X to $02
                    RTS                             ; (428A) Return from Subroutine