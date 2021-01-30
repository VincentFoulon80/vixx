!ifndef is_main {
    is_main = 1
    !src "../../lib/x16.asm"
    !src "../../lib/vera.asm"
    !src "../../lib/math.asm"
    !src "../paper.asm"
    !src "../macros/screen.asm"
    *= $801
}

; =======================================================================================================
; ###  CLEARING  ########################################################################################
; =======================================================================================================

clear_layer0:
    ; set screen tiles to 
    +fn_vera_set_address $20 + vram_layer0_mapbase_b, vram_layer0_mapbase
    lda #$00
    ldy #$20
clear_layer0_char_lp:
    ldx #0
-   sta vera_data_0
    dex
    bne -
    dey
    bne clear_layer0_char_lp
    ; set screen colors to transparent
    +fn_vera_set_address $20 + vram_layer0_mapbase_b, vram_layer0_mapbase+1
    lda #$00
    ldy #$20
clear_layer0_color_lp:
    ldx #0
-   sta vera_data_0
    dex
    bne -
    dey
    bne clear_layer0_color_lp
    rts

clear_layer1:
    ; set screen chars to spaces
    +fn_vera_set_address $20 + vram_layer1_mapbase_b, vram_layer1_mapbase
    lda #$20
    ldy #$20
clear_layer1_char_lp:
    ldx #0
-   sta vera_data_0
    dex
    bne -
    dey
    bne clear_layer1_char_lp
    ; set screen colors to white on transparent
    +fn_vera_set_address $20 + vram_layer1_mapbase_b, vram_layer1_mapbase+1
    lda #$01
    ldy #$20
clear_layer1_color_lp:
    ldx #0
-   sta vera_data_0
    dex
    bne -
    dey
    bne clear_layer1_color_lp
    rts


fill_layer0:
    pha
    ; set screen tiles to 
    +fn_vera_set_address $20 + vram_layer0_mapbase_b, vram_layer0_mapbase
    ldy #$20
    pla
fill_layer0_char_lp:
-   sta vera_data_0
    dex
    bne -
    dey
    bne fill_layer0_char_lp

    rts

; =======================================================================================================
; ###  PRINTING  ########################################################################################
; =======================================================================================================

; moves the cursor and print a string
; params:
;     r0: pointer to the string
;     r1: cursor location
locate:
    phx         ; \ stash x and y
    phy         ; /
    clc             ; clear carry, to SET the cursor
    ldy x16_r1_l    ; \ load the location
    ldx x16_r1_h    ; /
    jsr PLOT        ; move the cursor
    plx         ; \
    ply         ; / retrieve x and y

; print a string
; params:
;     r0: pointer to the string
print:
-   lda (x16_r0_l)  ; print loop
    beq +           ; if the character is byte $00 we jump on the first '+' label after this line
    jsr CHROUT      ; print character on screen
    +inc16 x16_r0   ; increment pointer
    jmp -           ; end of the loop, jump to the first '-' label before this line
+   rts