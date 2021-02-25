!ifndef is_main !eof

id_mov_null = $00
mov_null:
    jmp mov_done            ; )- do nothing

id_mov_reset = $01
mov_reset:
    stz r_obj_x             ; \
    lda #$FF                ;  |
    sta r_obj_y             ;  |- clean object properties
    stz r_obj_t             ;  |  and make it mov_null
    stz r_obj_p             ;  |
    jmp mov_done            ; /

id_mov_plyr = $02
mov_player:
    lda #0                  ; \_ fetch joy0
    jsr joystick_get        ; /
    tay
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

id_mov_circ = $07
mov_lut_circle:
    lda frame_count         ; \
    and #$01                ;  |- move only on odd frames
    beq .mov_lut_circle_end ; /
    ldy r_obj_p             ; )- load step count
    lda r_obj_x             ; \
    clc                     ;  |- add X position
    adc .lut_circle_lut,Y   ;  |  based on step
    sta r_obj_x             ; /
    iny                     ; )- increment step
    lda r_obj_y             ; \
    clc                     ;  |- add Y position
    adc .lut_circle_lut,Y   ;  |  based on step
    sta r_obj_y             ; /
    iny                     ; )- increment step
    cpy #$20                ; \
    bne +                   ;  |- loop y after $20 steps
    ldy #$00                ; /
+   sty r_obj_p             ; )- store step count
.mov_lut_circle_end         ; \_ end of movement
    jmp mov_done            ; /

.lut_circle_lut:
!byte  6, 0
!byte  4, 2
!byte  4, 4
!byte  2, 4
!byte  0, 6
!byte -2, 4
!byte -4, 4
!byte -4, 2
!byte -6, 0
!byte -4,-2
!byte -4,-4
!byte -2,-4
!byte  0,-6
!byte  2,-4
!byte  4,-4
!byte  4,-2

id_mov_bcir = $08
mov_lut_big_circle:
    lda frame_count             ; \
    and #$01                    ;  |- move only on odd frames
    beq .mov_lut_big_circle_end ; /
    ldy r_obj_p                 ; )- load step count
    lda r_obj_x                 ; \
    clc                         ;  |- add X position
    adc .lut_big_circle_lut,Y   ;  |  based on step
    sta r_obj_x                 ; /
    iny                         ; )- increment step
    lda r_obj_y                 ; \
    clc                         ;  |- add Y position
    adc .lut_big_circle_lut,Y   ;  |  based on step
    sta r_obj_y                 ; /
    iny                         ; )- increment step
    cpy #$40                    ; \
    bne +                       ;  |- loop y after $40 steps
    ldy #$00                    ; /
+   sty r_obj_p                 ; )- store step count
.mov_lut_big_circle_end         ; \_ end of movement
    jmp mov_done                ; /

.lut_big_circle_lut:
!byte  6, 0
!byte  5, 1
!byte  4, 2
!byte  3, 3
!byte  4, 4
!byte  3, 3
!byte  2, 4
!byte  1, 5
!byte  0, 6
!byte -1, 5
!byte -2, 4
!byte -3, 3
!byte -4, 4
!byte -3, 3
!byte -4, 2
!byte -5, 1
!byte -6, 0
!byte -5,-1
!byte -4,-2
!byte -3,-3
!byte -4,-4
!byte -3,-3
!byte -2,-4
!byte -1,-5
!byte  0,-6
!byte  1,-5
!byte  2,-4
!byte  3,-3
!byte  4,-4
!byte  3,-3
!byte  4,-2
!byte  5,-1


id_mov_rng = $09
mov_rng:            
    jsr rng         ; \ 
    and #$55        ;  |- load param with a random value
    sta r_obj_p     ; /
    jsr rng         ; \
    cmp #$00        ;  |- if rng() is negative
    bpl +           ; /
    jmp mov_inc     ; )- then do an increment movement
+   jmp mov_dec     ; )- else do a decrement movement


id_mov_Iinc = $0A
mov_Iinc:
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
+   clc             ; \
    adc r_obj_x     ;  |- perform addition on x
    sta r_obj_x     ; /
    lda r_obj_p     ; \_ load parameter's right side
    and #$0F        ; /
    clc             ; \_ roll one time to do the 1/2 speed
    ror             ; /
    bcc +           ; \
    cpx #$01        ;  |- if lowest bit set AND frame count odd:
    bne +           ; /
    inc r_obj_y     ; )- then increment y
+   clc             ; \
    adc r_obj_y     ;  |- perform addition on y
    sta r_obj_y     ; /
    jmp mov_done    ; )- end of movement

mov_dbg:            ; \
    !byte $DB       ;  |- invoke the debugger
    jmp mov_done    ; /

; function table for movements

obj_fn_table:
!word mov_null, mov_reset, mov_player, mov_inc, mov_dec, mov_inc_dec, mov_dec_inc, mov_lut_circle, mov_lut_big_circle, mov_rng, mov_Iinc