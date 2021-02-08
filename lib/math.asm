; Get the left part of a byte
; rolls the part to the right
; params
;   accumulator
!macro get_left {
    lsr
    lsr
    lsr
    lsr
}

; Get the right part of a byte
; params
;   accumulator
!macro get_right {
    and #$0F
}

; Increment for 16 bit values
; params
;   .address:   address of a 16-bit value
!macro inc16 .address {
    inc .address        ; increment low byte
    bne +               ; if byte reached zero (an overflow occured)
    inc .address+1      ; increment high byte
+
}

; Decrement for 16 bit values
; params
;   .address:   address of a 16-bit value
!macro dec16 .address {
    lda .address        ; load low byte
    bne +               ; if byte is zero
    dec .address+1      ; decrement high byte
+   dec .address        ; after that, decrement low byte
}

; Add with Carry for 16 bit values of a 8 bit value
; no carry operation is performed before and after the actual addition
; params
;   .address:   address of a 16-bit value
;   .value:     8-bit value
!macro adc16 .address, .value {
    lda .address        ; load low byte
    adc #.value         ; add the value
    bcc +               ; if the carry is set
    inc .address+1      ; increment the high byte
+   sta .address        ; store the low byte
}

; Add with Carry for 16 bit values of a 8 bit value
; no carry operation is performed before and after the actual addition
; params
;   .address:   address of a 16-bit value
;   .value:     address
!macro adc16_ptr .address, .value {
    lda .address        ; load low byte
    adc .value          ; add the value
    bcc +               ; if the carry is set
    inc .address+1      ; increment the high byte
+   sta .address        ; store the low byte
}

; Substract with Carry for 16 bit values of a 8 bit value
; no carry operation is performed before and after the actual substraction
; params
;   .address:   address of a 16-bit value
;   .value:     8-bit value
!macro sbc16 .address, .value {
    lda .address        ; load low byte
    sbc #.value         ; substract the value
    bcs +               ; if the carry is cleared
    dec .address+1      ; decrement the high byte
+   sta .address        ; store the low byte
}

; Add with Carry for 16 bit values of a 16 bit value
; no carry operation is performed before and after the actual addition
; params
;   .address:   address of a 16-bit value
;   .value:     16-bit value
!macro adc16_16 .address, .value {
    lda .address        ; \
    adc #<.value        ;  |- classic addition of low byte
    sta .address        ; /
    lda .address+1      ; \
    adc #>.value        ;  |- classic addition of high byte (the carry will do its job)
    sta .address+1      ; /
}

; Add with Carry for 16 bit values of a 16 bit value
; no carry operation is performed before and after the actual addition
; params
;   .address:   address of a 16-bit value
;   .value:     16-bit adress
!macro adc16_16_ptr .address, .value {
    lda .address        ; \
    adc <.value         ;  |- classic addition of low byte
    sta .address        ; /
    lda .address+1      ; \
    adc >.value         ;  |- classic addition of high byte (the carry will do its job)
    sta .address+1      ; /
}

; Substract with Carry for 16 bit values of a 16 bit value
; no carry operation is performed before and after the actual substraction
; params
;   .address:   address of a 16-bit value
;   .value:     16-bit value
!macro sbc16_16 .address, .value {
    lda .address        ; \
    sbc #<.value        ;  |- classic substraction of low byte
    sta .address        ; /
    lda .address+1      ; \
    sbc #>.value        ;  |- classic substraction of high byte (the carry will do its job)
    sta .address+1      ; /
}

; Multiply a value with another one
; params
;   .value:         8-bit value
;   .multiplier:    8-bit value
!macro multiply .value, .multiplier {
    lda #.value
    +mul .multiplier
}

; Accumulator Multiply
; params
;   Accumulator:    8-bit value
;   .multiplier:    8-bit value
!macro mul .multiplier {
    tax
    lda #0
-   clc
    adc #.multiplier
    dex 
    bne -
}

!macro mul16 .address, .multiplier, .result {
    ldx #.multiplier
    stz .result
    stz .result+1
-   clc
    +adc16_16_ptr .result, .address
    dex 
    bne -
}

; Divide a value with another one
; params
;   .dividend:   8-bit value
;   .divider:    8-bit value
!macro divide .dividend, .divider {
    lda #.dividend      ; load the dividend
    +dva .divider
}

; Divide Accumulator
; params
;   Accumulator:    8-bit value
;   .divider:       8-bit value
!macro dva .divider {
    ; assuming the accumulator contains the dividend and the divider is not zero
    ldx #0              ; reset the x register
    sec                 ; set the carry (for the following substractions)
-   inx                 ; incement x
    sbc #.divider       ; substract the divider
    bcs -               ; if the carry is cleared (the result is now positive)
    dex
    txa                 ; transfer x to accumulator
}

; Modulate a value with another one
; params
;   .value:   8-bit value
;   .base:    8-bit value
!macro modulo .value, .base {
    lda #.value     ; load the value
    +mda .base
}

; Modulate Accumulator
; params
;   Accumulator:    8-bit value
;   .base:          8-bit value
!macro mda .base {
    ; assuming the accumulator contains the main value and the base is not zero
    sec             ; set the carry (for the following substractions)
-   sbc #.base      ; substraction loop
    bcs -           ; until the carry is cleared (the result is now negative)
    adc #.base      ; restore the value to the positive side
}

; Square root of a value
; see : http://6502org.wikidot.com/software-math-sqrt
; params
;   .value:     address to a 16-bit value
;   .result:    address to a 8-bit value (output)
;   .remainder: address to a 8-bit value (output)
; additional output:
;   Flag Carry: 9th bit of the remainder
!macro squareroot .value, .result, .remainder {
    stz .result
    stz .remainder
    ldx #8
-   sec
    lda .value+1
    sbc #$40
    tay
    lda .remainder
    sbc .result
    bcc +
    sty .value+1
    sta .remainder
+   rol .result
    asl .value
    rol .value+1
    rol .remainder
    asl .value
    rol .value+1
    rol .remainder
    dex
    bne -
}