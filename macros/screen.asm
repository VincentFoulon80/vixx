!macro fn_plot .x, .y {
    phx
    phy
    clc
    ldy #.x
    ldx #.y
    jsr PLOT 
    ply
    plx
}

!macro fn_locate .x, .y, .string_ptr {
    lda #<.string_ptr
    sta x16_r0_l
    lda #>.string_ptr
    sta x16_r0_h
    lda #.x
    sta x16_r1
    lda #.y
    sta x16_r1+1
    jsr locate
}

!macro fn_print .string_ptr {
    lda #<.string_ptr
    sta x16_r0_l
    lda #>.string_ptr
    sta x16_r0_h
    jsr print
}