is_main = 1

!src "../lib/x16.asm"
!src "../lib/irq.asm"
!src "../lib/vera.asm"
!src "../lib/math.asm"

!src "paper.asm"

!src "macros/screen.asm"

; =======================================================================================================
; ###  #####   ######  ######  ######  ######  ######  #####   ######  ######  ##########################
; ###  ##  ##  ##  ##  ##  ##    ##    ##        ##    ##  ##  ##  ##  ##  ##  ##########################
; ###  ####    ##  ##  ##  ##    ##    ######    ##    ####    ######  ######  ##########################
; ###  ##  ##  ##  ##  ##  ##    ##        ##    ##    ##  ##  ##  ##  ##      ##########################
; ###  #####   ######  ######    ##    ######    ##    ##  ##  ##  ##  ##      ##########################
; =======================================================================================================
prg_boot:
    +basic_startup 
    +fn_vera_init_subroutines
    +game_video_init 
    +game_init

    ;setup player sprite
    +fn_vera_upload bullet, $10+vram_sprites_base_b, vram_sprites_base, bullet_packet_size, bullet_packet_qty    ; $11 = increment 1, bank 0, $0000 = address, $FF = size+1, $01 = 1 times
    
    +fn_vera_set_address %00010001, $FC00 ; increment 1, bank 1, address FC00 + index*8
    ldx $00
-
    lda #<$0400     
    sta vera_data_0 ; addr_mode
    lda #>$0400     
    sta vera_data_0 ; addr_mode
    stz vera_data_0 ; pos x (low)
    stz vera_data_0 ; pos x (high)
    stz vera_data_0 ; pos y (low)
    stz vera_data_0 ; pos y (high)

    lda #vera_sprite_zdepth_behind_layer1
    sta vera_data_0
    lda #vera_sprite_width_8px | vera_sprite_height_8px
    sta vera_data_0

    dex
    bne -

    +fn_vera_set_video vera_video_mask_sprite | vera_video_mask_layer1 | vera_video_mask_output_vga

    jsr clear_layer0
    jsr clear_layer1

    +fn_locate 0, 0, str_ui_full_row
    +fn_locate 0, 1, str_ui_game_row
    +fn_locate 0, 2, str_ui_hiscore_lbl_row
    +fn_locate 0, 3, str_ui_empty_slot_row
    +fn_locate 0, 4, str_ui_game_row
    +fn_locate 0, 5, str_ui_score_lbl_row
    +fn_locate 0, 6, str_ui_empty_slot_row
    +fn_locate 0, 7, str_ui_game_row
    +fn_locate 0, 8, str_ui_lives_lbl_row
    +fn_locate 0, 9, str_ui_empty_slot_row
    +fn_locate 0,10, str_ui_game_row
    +fn_locate 0,11, str_ui_game_row
    +fn_locate 0,12, str_ui_game_row
    +fn_locate 0,13, str_ui_game_row
    +fn_locate 0,14, str_ui_game_row
    +fn_locate 0,15, str_ui_game_row
    +fn_locate 0,16, str_ui_game_row
    +fn_locate 0,17, str_ui_game_row
    +fn_locate 0,18, str_ui_game_row
    +fn_locate 0,19, str_ui_game_row
    +fn_locate 0,20, str_ui_game_row
    +fn_locate 0,21, str_ui_game_row
    +fn_locate 0,22, str_ui_game_row
    +fn_locate 0,23, str_ui_game_row
    +fn_locate 0,24, str_ui_game_row
    +fn_locate 0,25, str_ui_game_row
    +fn_locate 0,26, str_ui_game_row
    +fn_locate 0,27, str_ui_game_row
    +fn_locate 0,28, str_ui_game_row
    +fn_locate 0,29, str_ui_full_row
    
    
    +fn_locate 9,10,str_press_enter

    jsr CHRIN

    +fn_locate 0,10, str_ui_game_row
    jsr reset_objects
    jsr refresh_score
    jsr refresh_lives

    +fn_irq_init kernal_irq, vsync_loop


; =======================================================================================================
; ###  ######  ######  ##     ##  ######      ##      ######  ######  ######  ###########################
; ###  ##      ##  ##  #### ####  ##          ##      ##  ##  ##  ##  ##  ##  ###########################
; ###  ## ###  ######  ## ### ##  #####       ##      ##  ##  ##  ##  ######  ###########################
; ###  ##  ##  ##  ##  ##  #  ##  ##          ##      ##  ##  ##  ##  ##      ###########################
; ###  ######  ##  ##  ##     ##  ######      ######  ######  ######  ##      ###########################
; =======================================================================================================


game_loop:
    lda game_mode
    cmp #$FF
    bne +
    !byte $DB
    +fn_irq_restore kernal_irq
    rts
+

    lda wait_frame
    and #WFRAME_MOVE
    beq +
    jmp update_collisions_end
+   lda wait_frame
    ora #WFRAME_MOVE
    sta wait_frame
update_game:
    jsr optimize_object_count
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
    jmp update_collisions_end   ; /
+
update_collisions:
    lda #<obj_table         ; \
    sta r_obj_a             ;  |
    lda #>obj_table         ;  |- object lookup loop init
    sta r_obj_a+1           ;  |
    ldy obj_count           ;  |
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
    jmp update_collisions_end;/
+   jsr handle_graze        ; )- check grazing
    jmp -

update_collisions_end:

!src "routines/choregraphy.asm"

    jmp game_loop

; =======================================================================================================
; ###  ######  ##  ##  #####   #####   ######  ##  ##  ######  ##  ##    ##  ######  ######  ############
; ###  ##      ##  ##  ##  ##  ##  ##  ##  ##  ##  ##    ##    ##  ####  ##  ##      ##      ############
; ###  ######  ##  ##  ####    ####    ##  ##  ##  ##    ##    ##  ## ## ##  #####   ######  ############
; ###      ##  ##  ##  ##  ##  ##  ##  ##  ##  ##  ##    ##    ##  ##  ####  ##          ##  ############
; ###  ######  ######  #####   ##  ##  ######  ######    ##    ##  ##    ##  ######  ######  ############
; =======================================================================================================


!src "routines/screen.asm"

; ###########################
; returns a random byte to A (0-255)
; resets Y to 0
rng:
    ldy #8     ; iteration count (generates 8 bits)
	lda rng_seed_0
-
	asl        ; shift the register
	rol rng_seed_1
	bcc +
	eor #$39   ; apply XOR feedback whenever a 1 bit is shifted out
+
	dey
	bne -
	sta rng_seed_0
	cmp #0     ; reload flags
	rts
; ###########################

!src "routines/game.asm"

; =======================================================================================================
; ###  ##  ##  ######  ##  ##  ##    ##  ######      ##      ######  ######  ######  ####################
; ###  ##  ##  ##      ##  ##  ####  ##  ##          ##      ##  ##  ##  ##  ##  ##  ####################
; ###  ##  ##  ######   ####   ## ## ##  ##          ##      ##  ##  ##  ##  ######  ####################
; ###   ####       ##    ##    ##  ####  ##          ##      ##  ##  ##  ##  ##      ####################
; ###    ##    ######    ##    ##    ##  ######      ######  ######  ######  ##      ####################
; =======================================================================================================

vsync_loop:
    lda vera_isr
    and #vera_isr_mask_vsync
    bne +
    jmp irq_done
+

draw_sprites:
    lda #%00010001          ; \_ set vera stride & bank values
    sta vera_stride_bank    ; /
    lda #$FC                ; \
    sta vera_high_addr      ;  |- set vera to the sprite address
    lda #$02                ;  |
    sta vera_low_addr       ; /
    lda #<obj_table-obj_size; \
    sta unsafe_addr_l       ;  |- init object address
    lda #>obj_table-obj_size;  |
    sta unsafe_addr_h       ; /
    ldy obj_count           ; \
    iny                     ;  |
    phy                     ;  |
draw_sprites_lp:            ;  |
    clc                     ;  |- for x=obj_count to 0
    +adc16 unsafe_addr,obj_size;- addr += obj_size
    ply                     ;  |
    dey                     ;  |
    beq draw_sprites_done   ; /
    phy
    ldy #obj_idx_pos_x      ; \
    lda (unsafe_addr),Y     ;  |- update pos x
    sta vera_data_0         ;  |
    stz vera_data_0         ; /
    ldy #obj_idx_pos_y      ; \
    lda (unsafe_addr),Y     ;  |- update pos y
    sta vera_data_0         ;  |
    stz vera_data_0         ; /

    lda vera_data_0         ; \
    lda vera_data_0         ;  |- sprite data padding
    lda vera_data_0         ;  |
    lda vera_data_0         ; /
    jmp draw_sprites_lp
draw_sprites_done:

irq_done:
    stz wait_frame
    inc frame_count
    jmp (kernal_irq)

; =======================================================================================================
; ###  #####   ######  ######  ######  ##  ##  #####   ######  ######  ######  ##########################
; ###  ##  ##  ##      ##      ##  ##  ##  ##  ##  ##  ##      ##      ##      ##########################
; ###  ####    #####   ######  ##  ##  ##  ##  ####    ##      #####   ######  ##########################
; ###  ##  ##  ##          ##  ##  ##  ##  ##  ##  ##  ##      ##          ##  ##########################
; ###  ##  ##  ######  ######  ######  ######  ##  ##  ######  ######  ######  ##########################
; =======================================================================================================

!src "resources/strings.asm"
!src "resources/sprites.asm"

!src "movements.asm"

*=choregraphy_start
; insert player
!byte CHOR_OP_SPS, $6F, $C7
!byte CHOR_OP_INS, id_mov_plyr, $00
; first section
!byte CHOR_OP_SPS, $6F, $20
!byte CHOR_OP_INS, id_mov_dcic, $20
!byte CHOR_OP_INS, id_mov_dcic, $21
!byte CHOR_OP_INS, id_mov_dcic, $11
!byte CHOR_OP_INS, id_mov_dcic, $12
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_INS, id_mov_incr, $12
!byte CHOR_OP_INS, id_mov_incr, $11
!byte CHOR_OP_INS, id_mov_incr, $21
!byte CHOR_OP_INS, id_mov_incr, $20
; prepare slide loop
!byte CHOR_OP_SPS, $20, $20
!byte CHOR_OP_LDA, $08
!byte CHOR_OP_SLP, $FC

.choregraphy_slide:
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_INS, id_mov_incr, $12
!byte CHOR_OP_INS, id_mov_dcic, $12
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.choregraphy_slide, >.choregraphy_slide
; next section
!byte CHOR_OP_SLP, $30
!byte CHOR_OP_SPS, $6F, $20
!byte CHOR_OP_INS, id_mov_dcic, $40
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_dcic, $31
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_dcic, $22
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_dcic, $13
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_dcic, $04
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_incr, $13
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_incr, $22
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_incr, $31
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_LDA, $05
!byte CHOR_OP_SLP, $30

.choregraphy_explosion:
!byte CHOR_OP_INS, id_mov_dcic, $40
!byte CHOR_OP_INS, id_mov_dcic, $31
!byte CHOR_OP_INS, id_mov_dcic, $22
!byte CHOR_OP_INS, id_mov_dcic, $13
!byte CHOR_OP_INS, id_mov_dcic, $04
!byte CHOR_OP_INS, id_mov_incr, $13
!byte CHOR_OP_INS, id_mov_incr, $22
!byte CHOR_OP_INS, id_mov_incr, $31
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JAN, <.choregraphy_explosion, >.choregraphy_explosion

!byte CHOR_OP_LDA, $08
.choregraphy_slide_explosion:
!byte CHOR_OP_SPS, $4F, $20
!byte CHOR_OP_INS, id_mov_incr, $04
!byte CHOR_OP_INS, id_mov_incr, $24
!byte CHOR_OP_INS, id_mov_dcic, $24
!byte CHOR_OP_SPS, $8F, $20
!byte CHOR_OP_INS, id_mov_incr, $04
!byte CHOR_OP_INS, id_mov_incr, $24
!byte CHOR_OP_INS, id_mov_dcic, $24
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JAN, <.choregraphy_slide_explosion, >.choregraphy_slide_explosion

!byte CHOR_OP_SPS, $08, $30
!byte CHOR_OP_INS, id_mov_incr, $10
!byte CHOR_OP_INS, id_mov_incr, $20
!byte CHOR_OP_INS, id_mov_incr, $30
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_INS, id_mov_incr, $50
!byte CHOR_OP_SPS, $08, $50
!byte CHOR_OP_INS, id_mov_incr, $10
!byte CHOR_OP_INS, id_mov_incr, $20
!byte CHOR_OP_INS, id_mov_incr, $30
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_INS, id_mov_incr, $50
!byte CHOR_OP_SPS, $08, $70
!byte CHOR_OP_INS, id_mov_incr, $10
!byte CHOR_OP_INS, id_mov_incr, $20
!byte CHOR_OP_INS, id_mov_incr, $30
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_INS, id_mov_incr, $50
!byte CHOR_OP_SPS, $08, $90
!byte CHOR_OP_INS, id_mov_incr, $10
!byte CHOR_OP_INS, id_mov_incr, $20
!byte CHOR_OP_INS, id_mov_incr, $30
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_INS, id_mov_incr, $50
!byte CHOR_OP_SPS, $08, $B0
!byte CHOR_OP_INS, id_mov_incr, $10
!byte CHOR_OP_INS, id_mov_incr, $20
!byte CHOR_OP_INS, id_mov_incr, $30
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_INS, id_mov_incr, $50
!byte CHOR_OP_SPS, $D9, $30
!byte CHOR_OP_INS, id_mov_decr, $10
!byte CHOR_OP_INS, id_mov_decr, $20
!byte CHOR_OP_INS, id_mov_decr, $30
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_INS, id_mov_decr, $50
!byte CHOR_OP_SPS, $D9, $50
!byte CHOR_OP_INS, id_mov_decr, $10
!byte CHOR_OP_INS, id_mov_decr, $20
!byte CHOR_OP_INS, id_mov_decr, $30
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_INS, id_mov_decr, $50
!byte CHOR_OP_SPS, $D9, $70
!byte CHOR_OP_INS, id_mov_decr, $10
!byte CHOR_OP_INS, id_mov_decr, $20
!byte CHOR_OP_INS, id_mov_decr, $30
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_INS, id_mov_decr, $50
!byte CHOR_OP_SPS, $D9, $90
!byte CHOR_OP_INS, id_mov_decr, $10
!byte CHOR_OP_INS, id_mov_decr, $20
!byte CHOR_OP_INS, id_mov_decr, $30
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_INS, id_mov_decr, $50
!byte CHOR_OP_SPS, $D9, $B0
!byte CHOR_OP_INS, id_mov_decr, $10
!byte CHOR_OP_INS, id_mov_decr, $20
!byte CHOR_OP_INS, id_mov_decr, $30
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_INS, id_mov_decr, $50

.choregraphy_end:
!byte CHOR_OP_SLP, $FF
!byte CHOR_OP_JMP, <.choregraphy_end, >.choregraphy_end

*=obj_count
!byte $0A

*=obj_table
;        type    ,par, x , y 
!byte id_mov_plyr,$00,$6F,$C7
!byte id_mov_dcic,$20,$6F,$20
!byte id_mov_dcic,$21,$6F,$20
!byte id_mov_dcic,$11,$6F,$20
!byte id_mov_dcic,$12,$6F,$20
!byte id_mov_incr,$02,$6F,$20
!byte id_mov_incr,$12,$6F,$20
!byte id_mov_incr,$11,$6F,$20
!byte id_mov_incr,$21,$6F,$20
!byte id_mov_incr,$20,$6F,$20

*=obj_fn_table
!word mov_null, mov_reset, mov_player, mov_inc, mov_dec, mov_inc_dec, mov_dec_inc;, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg
; note : mov_null doit rien faire, et ajouter un mov_reset pour forcer la position