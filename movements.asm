!ifndef is_main {
    !src "../lib/x16.asm"
    !src "paper.asm"
    *= $801
mov_done:
}

id_mov_null = $00
mov_null:
    stz r_obj_x
    lda #$FF
    sta r_obj_y
    jmp mov_done

id_mov_plyr = $01
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

id_mov_incr = $02
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
    bne +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   clc             ; \
    adc r_obj_x     ;  |- perform addition on x
    bcc +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_y     ; )- then increment y
    bne +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   clc             ; \
    adc r_obj_y     ;  |- perform addition on y
    bcc +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_decr = $03                 
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
    dec r_obj_x     ; )- then increment x
    bpl +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   sta r_obj_r0    ; \
    lda r_obj_x     ;  |
    sec             ;  |- perform substract on x
    sbc r_obj_r0    ;  |
    bpl +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_y     ; )- then increment y
    bpl +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   sta r_obj_r0    ; \
    lda r_obj_y     ;  |
    sec             ;  |- perform substract on y
    sbc r_obj_r0    ;  |
    bpl +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_icdc = $04
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
    bne +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   clc             ; \
    adc r_obj_x     ;  |- perform addition on x
    bcc +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    dec r_obj_y     ; )- then increment y
    bpl +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   sta r_obj_r0    ; \
    lda r_obj_y     ;  |
    sec             ;  |- perform substract on y
    sbc r_obj_r0    ;  |
    bpl +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

id_mov_dcic = $05
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
    dec r_obj_x     ; )- then increment x
    bpl +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   sta r_obj_r0    ; \
    lda r_obj_x     ;  |
    sec             ;  |- perform substract on x
    sbc r_obj_r0    ;  |
    bcs +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_y     ; )- then increment y
    bne +           ; \_ kill on OOB
    stz r_obj_t     ; /
+   clc             ; \
    adc r_obj_y     ;  |- perform addition on y
    bcc +           ;  | \_ kill on OOB
    stz r_obj_t     ;  | /
+   sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement