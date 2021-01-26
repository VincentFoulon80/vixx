!ifndef is_main {
    !src "../../lib/x16.asm"
    !src "../../lib/vera.asm"
    !src "../../lib/math.asm"
    !src "../paper.asm"
    !src "screen.asm"
    *= $801
}

; ###########################
insert_object:              ; insert a new object in the list
    lda #<obj_table         ; \
    sta r_obj_a             ;  |
    lda #>obj_table         ;  |- object lookup loop init
    sta r_obj_a+1           ;  |
    ldy obj_count           ;  |
    iny                     ;  |
    phy                     ; /
-   
    ply                     ; \
    dey                     ;  |- for y=0 to obj_count
    beq .insert_obj_not_found; |
    phy                     ; /
;   ldy #obj_idx_type       ; \_ load movement type
    lda (r_obj_a);,Y        ; /
    beq .insert_obj_insert  ; )- jmp if type is null
    clc                     ; \_ obj_addr += obj_size
    +adc16 r_obj_a, obj_size; /
    bra -                   ; )- next
   
.insert_obj_not_found:      ; no free slot found
    inc obj_count           ; )- increment counter and insert at the end
    lda obj_count
    cmp #$80
    bra +
    ; overflow, skip insert
    dec obj_count
    rts


.insert_obj_insert          ; free slot found
    ply
+   ldy #$01                ; \
    lda r_obj_t             ;  |- insert type
    sta (r_obj_a)           ; /
    lda r_obj_p             ; \_ insert parameter
    sta (r_obj_a),Y         ; /
    iny                     ; \
    lda r_obj_x             ;  |- insert x pos
    sta (r_obj_a),Y         ; /
    iny                     ; \
    lda r_obj_y             ;  |- insert y pos
    sta (r_obj_a),Y         ; /
    rts                     ; )- end of routine
; ###########################

; ###########################
optimize_object_count:
    lda #<obj_table         ; \
    sta r_obj_a             ;  |
    lda #>obj_table         ;  |- object lookup loop init
    sta r_obj_a+1           ; /
    ldy #$00                ; )- total count
    ldx #$00                ; )- last found
-                           ; 
    iny                     ; )- count item
    lda (r_obj_a)           ; )- load object type
    beq +                   ; )- if object is 0, skip to the next iteration
    tya                     ; \_ x = y
    tax                     ; /
+   cpy #$7F                ; \_ check if we reached the end
    beq +                   ; /
    clc                     ; \_ obj_addr += obj_size
    +adc16 r_obj_a, obj_size; /
    jmp -                   ; )- next
+                           ;
    stx obj_count           ; )- update object count
    rts                     ; )- end of routine
; ###########################

; ###########################
handle_touched:
    ldy #obj_idx_pos_x      ; \
    lda (r_obj_a),Y         ;  |- load object's x position
    sec                     ; <
    sbc plyr_x              ;  |- compare with player's x position
    bcc +                   ; /
    ; positive side         ; \
    cmp #$03                ;  |
    bcs .touched_end        ;  |
    jmp .touched_x          ;  |- check if distance (-+) 3
+   ;negative side          ;  |
    cmp #$FD                ;  |
    bcc .touched_end        ; /
.touched_x:                 ; \
    ldy #obj_idx_pos_y      ;  |- load object's y position
    lda (r_obj_a),Y         ; /
    sec                     ; \
    sbc plyr_y              ;  |- compare with player's y position
    bcc +                   ; /
    ; positive side         ; \
    cmp #$03                ;  |
    bcs .touched_end        ;  |
    jmp .touched_xy         ;  |- check if distance (-+) 3
+   ;negative side          ;  |
    cmp #$FD                ;  |
    bcc .touched_end        ; /
.touched_xy:                ; \
    sec                     ;  |- return with carry set (touched!)
    rts                     ; /
.touched_end:               ; \
    clc                     ;  |- return with carry clear (no touchy)
    rts                     ; /
; ###########################

; ###########################
handle_graze:
    ldy #obj_idx_pos_x      ; \
    lda (r_obj_a),Y         ;  |- load object's x position
    sec                     ; <
    sbc plyr_x              ;  |- compare with player's x position
    bcc +                   ; /
    ; positive side         ; \
    cmp #$09                ;  |
    bcs .grazed_end         ;  |
    jmp .grazed_x           ;  |- check if distance (-+) 9
+   ;negative side          ;  |
    cmp #$F7                ;  |
    bcc .grazed_end         ; /
.grazed_x:                  ; \
    ldy #obj_idx_pos_y      ;  |- load object's y position
    lda (r_obj_a),Y         ; /
    sec                     ; \
    sbc plyr_y              ;  |- compare with player's y position
    bcc +                   ; /
    ; positive side         ; \
    cmp #$09                ;  |
    bcs .grazed_end         ;  |
    jmp .grazed_xy          ;  |- check if distance (-+) 9
+   ;negative side          ;  |
    cmp #$F7                ;  |
    bcc .grazed_end         ; /
.grazed_xy:                 ;
    sed                     ; \_ set decimal and reset carry
    clc                     ; /
    lda score_21            ; \
    adc #GRAZE_BONUS        ;  |- increase first 2 digit
    sta score_21            ; /
    lda score_43            ; \
    adc #$00                ;  |- follow the 2 next digit
    sta score_43            ; /
    lda score_65            ; \
    adc #$00                ;  |- follow the 2 next digit
    sta score_65            ; /
    lda score_87            ; \
    adc #$00                ;  |- finally follow the last 2 digit
    sta score_87            ; /
    cld                     ; )- reset back to binary
    jsr refresh_score       ; )- refresh scores on screen
.grazed_end:                ;
    rts                     ; )- return
; ###########################

; ###########################
refresh_score:
    lda score_87
    +get_left
    ora #$30
    sta dynamic_string
    lda score_87
    +get_right
    ora #$30
    sta dynamic_string+1

    lda score_65
    +get_left
    ora #$30
    sta dynamic_string+2
    lda score_65
    +get_right
    ora #$30
    sta dynamic_string+3

    lda score_43
    +get_left
    ora #$30
    sta dynamic_string+4
    lda score_43
    +get_right
    ora #$30
    sta dynamic_string+5

    lda score_21
    +get_left
    ora #$30
    sta dynamic_string+6
    lda score_21
    +get_right
    ora #$30
    sta dynamic_string+7

    lda PET_NULL
    sta dynamic_string+8
    +fn_print str_color_score
    +fn_locate 30, 3, dynamic_string
    rts
; ###########################