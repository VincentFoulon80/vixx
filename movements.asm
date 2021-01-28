!ifndef is_main {
    !src "../lib/x16.asm"
    !src "paper.asm"
    *= $801
mov_done:
}

id_mov_null = $00
mov_null:
    jmp mov_done

id_mov_reset = $01
mov_reset:
    stz r_obj_x
    lda #$FF
    sta r_obj_y
    stz r_obj_t
    stz r_obj_p
    jmp mov_done

id_mov_plyr = $02
mov_player:
    lda #0
    jsr joystick_get        ; fetch joy0
    tay                     ; store the value into y
    and #joystick_mask_left ; check left button
    bne +                   ; or skip

    ; left is pressed
    lda r_obj_x             ; \
    cmp #$08                ;  |- prevent OOB
    bcc +                   ; /
    dec r_obj_x             ; )- move player

+   tya
    and #joystick_mask_right; check right button
    bne +                   ; or skip

    ; right is pressed
    lda r_obj_x             ; \
    cmp #$D9                ;  |- prevent OOB
    bcs +                   ; /
    inc r_obj_x             ; )- move player

+   tya
    and #joystick_mask_down ; check down button
    bne +                   ; or skip

    ; down is pressed
    lda r_obj_y             ; \
    cmp #$E1                ;  |- prevent OOB
    bcs +                   ; /
    inc r_obj_y             ; )- move player

+   tya
    and #joystick_mask_up   ; check up button
    bne +   

    ; up is pressed
    lda r_obj_y             ; \
    cmp #$08                ;  |- prevent OOB
    bcc +                   ; /
    dec r_obj_y             ; )- move player

+   
    lda r_obj_x
    sta plyr_x
    lda r_obj_y
    sta plyr_y
    jmp mov_done

id_mov_incr = $03
mov_inc:
    lda frame_count ; \
    and #$01        ;  |- load frame count parity into X
    tax             ; /
    lda r_obj_p     ; \_ load parameter's left side
    and #$F0        ; /
    clc             ; \
    ror             ;  |
    ror             ;  |- roll the parameter to the right
    ror             ;  |
    ror             ; /
    ror             ; )- roll one more time to do the 1/2 speed
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_x     ; )- then increment x
    bne +           ; \
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   clc             ; \
    adc r_obj_x     ;  |- perform addition on x
    bcc +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_y     ; )- then increment y
    bne +           ; \
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   clc             ; \
    adc r_obj_y     ;  |- perform addition on y
    bcc +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_decr = $04
mov_dec:
    lda frame_count ; \
    and #$01        ;  |- load frame count parity into X
    tax             ; /
    lda r_obj_p     ; \_ load parameter's left side
    and #$F0        ; /
    clc             ; \
    ror             ;  |
    ror             ;  |- roll the parameter to the right
    ror             ;  |
    ror             ; /
    ror             ; )- roll one more time to do the 1/2 speed
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_x     ; )- then decrement x
    ldy r_obj_x     ; \
    cpy #$FF        ;  |
    bne +           ;  |
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   sta r_obj_r0    ; \
    lda r_obj_x     ;  |
    sec             ;  |- perform substract on x
    sbc r_obj_r0    ;  |
    bcs +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_y     ; )- then decrement y
    ldy r_obj_y     ; \
    cpy #$FF        ;  |
    bne +           ;  |
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   sta r_obj_r0    ; \
    lda r_obj_y     ;  |
    sec             ;  |- perform substract on y
    sbc r_obj_r0    ;  |
    bcs +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_icdc = $05
mov_inc_dec:
    lda frame_count ; \
    and #$01        ;  |- load frame count parity into X
    tax             ; /
    lda r_obj_p     ; \_ load parameter's left side
    and #$F0        ; /
    clc             ; \
    ror             ;  |
    ror             ;  |- roll the parameter to the right
    ror             ;  |
    ror             ; /
    ror             ; )- roll one more time to do the 1/2 speed
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_x     ; )- then increment x
    bne +           ; \
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   clc             ; \
    adc r_obj_x     ;  |- perform addition on x
    bcc +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_y     ; )- then decrement y
    ldy r_obj_y     ; \
    cpy #$FF        ;  |
    bne +           ;  |
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   sta r_obj_r0    ; \
    lda r_obj_y     ;  |
    sec             ;  |- perform substract on y
    sbc r_obj_r0    ;  |
    bcs +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_dcic = $06
mov_dec_inc:
    lda frame_count ; \
    and #$01        ;  |- load frame count parity into X
    tax             ; /
    lda r_obj_p     ; \_ load parameter's left side
    and #$F0        ; /
    clc             ; \
    ror             ;  |
    ror             ;  |- roll the parameter to the right
    ror             ;  |
    ror             ; /
    ror             ; )- roll one more time to do the 1/2 speed
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_x     ; )- then decrement x
    ldy r_obj_x     ; \
    cpy #$FF        ;  |
    bne +           ;  |
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   sta r_obj_r0    ; \
    lda r_obj_x     ;  |
    sec             ;  |- perform substract on x
    sbc r_obj_r0    ;  |
    bcs +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_y     ; )- then increment y
    bne +           ; \
    lda #id_mov_reset; |- kill on OOB
    sta r_obj_t     ;  |
    jmp mov_done    ; /
+   clc             ; \
    adc r_obj_y     ;  |- perform addition on y
    bcc +           ;  | \
    lda #id_mov_reset; |  |- kill on OOB
    sta r_obj_t     ;  |  |
    jmp mov_done    ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement


mov_dbg:
    !byte $DB
    jmp mov_done