!ifndef is_main !eof


    lda wait_frame
    and #WFRAME_MOVE
    beq +
    jmp update_collisions_end
+   lda wait_frame
    ora #WFRAME_MOVE
    sta wait_frame
update_game:
    lda frame_count
    and #$0F
    bne +
    lda invincibility_cnt
    bne +
    lda score_over_time
    ldx #$00
    ldy #$00
    jsr add_to_score
+   jsr optimize_object_count
    lda #<obj_table         ; \
    sta r_obj_a             ;  |
    lda #>obj_table         ;  |- object lookup loop init
    sta r_obj_a+1           ;  |
    ldy obj_count           ;  |
    iny                     ;  |
    phy                     ; /
-                           ; \
    ply                     ;  |
    dey                     ;  |- for y=obj_count to 0
    beq +                   ;  |
    phy                     ; /
;   ldy #obj_idx_type       ; \
    lda (r_obj_a);,Y        ;  |- load movement type
    sta r_obj_t             ; /
    ldy #obj_idx_param      ; \
    lda (r_obj_a),Y         ;  |- load movement param
    sta r_obj_p             ; /
    ldy #obj_idx_pos_x      ; \
    lda (r_obj_a),Y         ;  |- load pos x
    sta r_obj_x             ; /
    ldy #obj_idx_pos_y      ; \
    lda (r_obj_a),Y         ;  |- load pos y
    sta r_obj_y             ; /
;    ldy obj_idx_type       ; \ load type (skippable since first value)
    lda (r_obj_a);,Y        ; / lookup the object id
    clc                     ; \_ shift left to get a correct pointer order (every 2 bytes)
    rol                     ; /
    tax                     ; ) use x for indexed indirect addressing
    jmp (obj_fn_table,X)    ; ) jmp to object's movement routine based on the id
mov_done:
    ldy #obj_idx_param      ; \
    lda r_obj_p             ;  |- save param
    sta (r_obj_a),Y         ; /
    ldy #obj_idx_pos_x      ; \
    lda r_obj_x             ;  |- save x
    sta (r_obj_a),Y         ; /
    ldy #obj_idx_pos_y      ; \
    lda r_obj_y             ;  |- save y
    sta (r_obj_a),Y         ; /
;   ldy #obj_idx_type       ; \
    lda r_obj_t             ;  |- save type
    sta (r_obj_a);,Y        ; /
    clc                     ; \_ obj_addr += obj_size
    +adc16 r_obj_a, obj_size; /
    jmp -                   ; )- next object
+

    lda invincibility_cnt       ; \
    beq +                       ;  |- skip collisions when invincible
    dec invincibility_cnt       ;  |- count down the invincibility
    bne update_collisions_end   ;
    lda #player_spid            ;
    jsr change_player_sprite    ;
    jmp update_collisions_end   ; /
+
update_collisions:
    lda #<obj_table         ; \
    sta r_obj_a             ;  |
    lda #>obj_table         ;  |- object lookup loop init
    sta r_obj_a+1           ;  |
    ldy obj_count           ;  |
    beq update_collisions_end; |
    ;iny                    ;  |)- the first obj is the player
    phy                     ; /
-                           ; \
    clc                     ;  |\_ obj_addr += obj_size
    +adc16 r_obj_a, obj_size;  |/
    ply                     ;  |
    dey                     ;  |- for y=0 to obj_count
    beq update_collisions_end; |
    phy                     ; /
    jsr handle_touched      ; )- check touched
    bcc +                   ; \
    jsr player_touched      ;  |- Player has been touched! skip graze
    ply                     ;  |)- clean the stack
    bcs .game_gameover      ;  |
    jmp update_collisions_end;/
+   jsr handle_graze        ; )- check grazing
    jmp -

.game_gameover:
    lda #gamemode_gameover  
    sta game_mode           
    jmp change_gamemode     

update_collisions_end: