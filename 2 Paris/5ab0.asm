l_5AB0
                    LDX $5AA2                       ; (5AB0) Load X with $5AA2
                    BEQ l_5AE0                      ; (5AB3) Branch to $5AE0 if Equal
                    LDY $5AA3                       ; (5AB5) Load Y with Data from $5AA3
                    DEY                             ; (5AB8) Decrement Y Register
                    BPL l_5ABD                      ; (5AB9) Branch to $5ABD if positive
                    LDY #$07                        ; (5ABB) Load Y with #$07 (7 / 00000111)

l_5ABD
                    DEX                             ; (5ABD) Decrement X
                    BNE l_5AC6                      ; (5ABE) Branch to $5AC6 if Not Equal
                    STX ForwardReverse              ; (5AC0) Store X Register $03A4. #00 Forward / #08 Reverse.
                    STY CarFacingDirection          ; (5AC3) Store Y Register $03A0

l_5AC6
                    STX $5AA2                       ; (5AC6) Store X Register $5AA2
                    STY $5AA3                       ; (5AC9) Store Y Register $5AA3
                    LDA BondSPArray,Y               ; (5ACC) Load A with $03A8,Y
                    STA $AE                         ; (5ACF) Store A to $AE
                    CLC                             ; (5AD1) Clear Carry Flag
                    LDY #$BD                        ; (5AD2) Load Y with #$BD (189 / 10111101)
                    LDX #$AB                        ; (5AD4) Set X to #$AB (171 / 10101011)
                    LDA #$08                        ; (5AD6) Set A to #$08 (8 / 00001000)
                    JSR l_4200                      ; (5AD8) Jump to Subroutine at $4200
                    JMP l_4450                      ; (5ADB) Jump to $4450

* = $5ADE
            .byte $EA,$EA

* = $5AE0

l_5AE0
                    LDA $FE                         ; (5AE0) Load A with $FE
                    BNE l_5AF4                      ; (5AE2) Branch to $5AF4 if Not Equal
                    STA $5AA0                       ; (5AE4) Store A to $5AA0
                    LDA CarFacingDirection          ; (5AE7) Load A with $03A0. ;00 N / 01 NE / 02 E / 03 SE / 04 S / 05 SW / 06 W / 07 NW.
                    AND #$01                        ; (5AEA) Logical AND with Accumulator and #$01 (1 / 00000001)
                    EOR #$01                        ; (5AEC) Exclusive OR (XOR) with Accumulator and #$01 (1 / 00000001)
                    STA $5AA1                       ; (5AEE) Store A to $5AA1
                    JMP l_5B2A                      ; (5AF1) Jump to $5B2A

l_5AF4
                    CMP $5AA0                       ; (5AF4) Subtract $5AA0 from A
                    BNE l_5B04                      ; (5AF7) Branch to $5B04 if Not Equal
                    DEC $5AA1                       ; (5AF9) Decrement $5AA1
                    LDA $5AA1                       ; (5AFC) Load A with $5AA1
                    BMI l_5B40                      ; (5AFF) Branch to $5B40 if minus 
                    NOP                             ; (5B01) No operation
                    LDA $FE                         ; (5B02) Load A with $FE

l_5B04
                    BPL l_5B16                      ; (5B04) Branch to $5B16 if positive
                    LDX CarFacingDirection          ; (5B06) Load X with $03A0
                    DEX                             ; (5B09) Decrement X
                    CPX #$FF                        ; (5B0A) Subtract #$FF from X (255 / 11111111)
                    BNE l_5B10                      ; (5B0C) Branch to $5B10 if Not Equal
                    LDX #$07                        ; (5B0E) Set X to #$07 (7 / 00000111)

l_5B10
                    STX CarFacingDirection          ; (5B10) Store X Register $03A0
                    JMP l_5B25                      ; (5B13) Jump to $5B25

l_5B16
                    LDX CarFacingDirection          ; (5B16) Load X with $03A0
                    INX                             ; (5B19) Increment X
                    CPX #$08                        ; (5B1A) Subtract #$08 from X (8 / 00001000)
                    BNE l_5B10                      ; (5B1C) Branch to $5B10 if Not Equal
                    LDX #$00                        ; (5B1E) Set X to #$00 (0 / 00000000)
                    JMP l_5B10                      ; (5B20) Jump to $5B10

* = $5B23
            .byte $EA,$EA

* = $5B25

l_5B25
                    LDA $FE                         ; (5B25) Load A with $FE
                    STA $5AA0                       ; (5B27) Store A to $5AA0

l_5B2A
                    LDX CarFacingDirection          ; (5B2A) Load X with $03A0
                    LDA BondSPArray,X               ; (5B2D) Load A with BondSPArray,X
                    STA $AE                         ; (5B30) Store A to $AE
                    CLC                             ; (5B32) Clear Carry Flag
                    LDY #$BD                        ; (5B33) Load Y with #$BD (189 / 10111101)
                    LDX #$AB                        ; (5B35) Set X to #$AB (171 / 10101011)
                    LDA #$08                        ; (5B37) Set A to #$08 (8 / 00001000)
                    JSR l_4200                      ; (5B39) Jump to Subroutine at $4200. Update sprite pointer.
                    NOP                             ; (5B3C) No operation
                    NOP                             ; (5B3D) No operation
                    NOP                             ; (5B3E) No operation
                    NOP                             ; (5B3F) No operation

l_5B40
                    LDA $FE                         ; (5B40) Load A with $FE
                    BEQ l_5B51                      ; (5B42) Branch to $5B51 if Equal
                    LDA $07FD                       ; (5B44) Load A with $07FD
                    EOR #$02                        ; (5B47) Exclusive OR (XOR) with Accumulator and #$02 (2 / 00000010)
                    STA $07FD                       ; (5B49) Store A to $07FD
                    TAY                             ; (5B4C) Transfer A to Y
                    DEY                             ; (5B4D) Decrement Y Register
                    STY $07FC                       ; (5B4E) Store Y Register $07FC

l_5B51
                    JSR CheckJoyInputs              ; (5B51) Jump to Subroutine at $4260
                    LDA ForwardReverse              ; (5B54) Load A with $03A4. #00 Forward / #08 Reverse.
                    BNE l_5B89                      ; (5B57) Branch to $5B89 if reverse.
                    LDA $FD                         ; (5B59) Load A with $FD
                    BEQ l_5B86                      ; (5B5B) Branch to $5B86 if Equal
                    BPL DecreaseCarSpeed            ; (5B5D) Branch to $5B6F if positive

IncreaseCarSpeed
                    DEC CarSpeed                    ; (5B5F) Decrement $0340. Top speed #01 / Slowest speed #39.
                    LDA CarSpeed                    ; (5B62) Load A with $0340. Top speed #01 / Slowest speed #39.
                    BNE l_5B86                      ; (5B65) Branch to $5B86 if Not Equal
                    LDA #$01                        ; (5B67) Set A to #$01 (1 / 00000001). Top speed reached so set to #01.
                    STA CarSpeed                    ; (5B69) Store A to $0340. Top speed #01 / Slowest speed #39.
                    JMP l_5B86                      ; (5B6C) Jump to $5B86

DecreaseCarSpeed
                    INC CarSpeed                    ; (5B6F) Increment Memory $0340. Top speed #01 / Slowest speed #39.
                    LDA CarSpeed                    ; (5B72) Load A with $0340. Top speed #01 / Slowest speed #39.
                    CMP #$40                        ; (5B75) Subtract #$40 from A (64 / 01000000)
                    BNE l_5B86                      ; (5B77) Branch to $5B86 if Not Equal
                    LDA ForwardReverse              ; (5B79) Load A with $03A4. #00 Forward / #08 Reverse.
                    EOR #$08                        ; (5B7C) Exclusive OR (XOR) with Accumulator and #$08 (8 / 00001000)
                    STA ForwardReverse              ; (5B7E) Store A to $03A4. #00 Forward / #08 Reverse.
                    LDA #$3F                        ; (5B81) Set A to #$3F (63 / 00111111)
                    STA CarSpeed                    ; (5B83) Store A to $0340. Top speed #01 / Slowest speed #39.

l_5B86
                    JMP l_5B92                      ; (5B86) Jump to $5B92

l_5B89
                    LDA $FD                         ; (5B89) Load A with $FD
                    BEQ l_5B86                      ; (5B8B) Branch to $5B86 if Equal
                    BMI DecreaseCarSpeed            ; (5B8D) Branch to $5B6F if minus 
                    JMP IncreaseCarSpeed            ; (5B8F) Jump to $5B5F

l_5B92
                    LDA $02                         ; (5B92) Load A with $02
                    BEQ l_5BB8                      ; (5B94) Branch to $5BB8 if Equal
                    LDA $5AA2                       ; (5B96) Load A with $5AA2
                    BNE l_5BB8                      ; (5B99) Branch to $5BB8 if Not Equal
                    LDA ForwardReverse              ; (5B9B) Load A with $03A4. #00 Forward / #08 Reverse.
                    BEQ l_5BB5                      ; (5B9E) Branch to $5BB5 if Equal
                    LDA CarSpeed                    ; (5BA0) Load A with $0340. Top speed #01 / Slowest speed #39.
                    CMP #$15                        ; (5BA3) Subtract #$15 from A (21 / 00010101)
                    BCS l_5BB5                      ; (5BA5) Branch if Carry Set $5BB5
                    LDA #$04                        ; (5BA7) Set A to #$04 (4 / 00000100)
                    STA $5AA2                       ; (5BA9) Store A to $5AA2
                    LDA CarFacingDirection          ; (5BAC) Load A with $03A0
                    STA $5AA3                       ; (5BAF) Store A to $5AA3
                    JMP l_5A66                      ; (5BB2) Jump to $5A66

l_5BB5
                    JSR l_4570                      ; (5BB5) Jump to Subroutine at $4570

l_5BB8
                    JMP l_5A66                      ; (5BB8) Jump to $5A66