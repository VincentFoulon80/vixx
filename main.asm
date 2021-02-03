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
    
    ; upload tiles
    +fn_vera_upload t_empty, $10|t_empty_bank, t_empty_address, t_empty_packet_size, t_empty_packet_qty
    +fn_vera_direct_upload t_square, t_square_packet_size, t_square_packet_qty
    +fn_vera_direct_upload t_trace, t_trace_packet_size, t_trace_packet_qty
    +fn_vera_direct_upload t_scanl, t_scanl_packet_size, t_scanl_packet_qty


    ; upload sprites
    +fn_vera_upload bullet, $10|bullet_bank, bullet_address, bullet_packet_size, bullet_packet_qty
    +fn_vera_direct_upload bullet_glitch1, bullet_glitch1_packet_size, bullet_glitch1_packet_qty
    +fn_vera_direct_upload bullet_glitch2, bullet_glitch2_packet_size, bullet_glitch2_packet_qty
    +fn_vera_direct_upload player, player_packet_size, player_packet_qty
    +fn_vera_direct_upload touched_player, touched_player_packet_size, touched_player_packet_qty
    +fn_vera_direct_upload virus1, virus1_packet_size, virus1_packet_qty
    +fn_vera_direct_upload virus2, virus2_packet_size, virus2_packet_qty
    +fn_vera_direct_upload virus3, virus3_packet_size, virus3_packet_qty
    +fn_vera_direct_upload virus4, virus4_packet_size, virus4_packet_qty
    +fn_vera_direct_upload virus5, virus5_packet_size, virus5_packet_qty
    +fn_vera_direct_upload virus6, virus6_packet_size, virus6_packet_qty

    +game_init

    ; initializes sprites
    +fn_vera_set_address $10 + vera_mem_sprite_bank, vera_mem_sprite ; increment 1, bank 1, address FC00 + index*8

    lda #player_spid                        ; \
    sta vera_data_0                         ;  |
    lda #player_spid_def                    ;  |
    sta vera_data_0                         ;  |
    stz vera_data_0 ; pos x (low)           ;  |- init player sprite
    stz vera_data_0 ; pos x (high)          ;  |
    stz vera_data_0 ; pos y (low)           ;  |
    stz vera_data_0 ; pos y (high)          ;  |
                                            ;  |
    lda #vera_sprite_zdepth_behind_layer1   ;  |
    sta vera_data_0                         ;  |
    lda #player_spid_size                   ;  |
    sta vera_data_0                         ; /

    lda #virus1_spid                        ; \
    sta vera_data_0                         ;  |
    lda #virus1_spid_def                    ;  |
    sta vera_data_0                         ;  |
    stz vera_data_0 ; pos x (low)           ;  |- init virus sprite
    stz vera_data_0 ; pos x (high)          ;  |
    stz vera_data_0 ; pos y (low)           ;  |
    stz vera_data_0 ; pos y (high)          ;  |
                                            ;  |
    lda #vera_sprite_zdepth_behind_layer1   ;  |
    sta vera_data_0                         ;  |
    lda #virus1_spid_size                   ;  |
    sta vera_data_0                         ; /

    ldx #$7D
-                                           ; \
    lda #bullet_spid                        ;  |  
    sta vera_data_0                         ;  |- init all sprites
    lda #bullet_spid_def                    ;  |
    sta vera_data_0 ; addr_mode             ;  |
    stz vera_data_0 ; pos x (low)           ;  |- init bullet sprites
    stz vera_data_0 ; pos x (high)          ;  |
    stz vera_data_0 ; pos y (low)           ;  |
    stz vera_data_0 ; pos y (high)          ;  |
                                            ;  |
    lda #vera_sprite_zdepth_behind_layer1   ;  |
    sta vera_data_0                         ;  |
    lda #bullet_spid_size                   ;  |
    sta vera_data_0                         ;  |
                                            ;  |
    dex                                     ;  |
    bne -                                   ; /


    ; prepare game
    +fn_irq_init kernal_irq, vsync_loop

    lda #gamemode_title
    sta game_mode

; =======================================================================================================
; ###  ######  ######  ##     ##  ######      ##      ######  ######  ######  ###########################
; ###  ##      ##  ##  #### ####  ##          ##      ##  ##  ##  ##  ##  ##  ###########################
; ###  ## ###  ######  ## ### ##  #####       ##      ##  ##  ##  ##  ######  ###########################
; ###  ##  ##  ##  ##  ##  #  ##  ##          ##      ##  ##  ##  ##  ##      ###########################
; ###  ######  ##  ##  ##     ##  ######      ######  ######  ######  ##      ###########################
; =======================================================================================================

change_gamemode:
    lda game_mode

    cmp #gamemode_quit
    bne +
        jmp quit_game

+   cmp #gamemode_title
    bne +
        jmp title_screen

+   cmp #gamemode_game_init
    bne +
        jsr init_game_screen
        jsr init_game
        lda #gamemode_game
        sta game_mode
        jmp change_gamemode

+   cmp #gamemode_game
    bne +
        jmp game_loop

+   cmp #gamemode_gameover
    bne +
        jmp game_over

+   jmp quit_game


gamemode_quit = $FF
quit_game:
    +fn_irq_restore kernal_irq
    rts


gamemode_title = $00
title_screen:
    lda hiscore_21
    bne .score_loaded
    lda hiscore_43
    bne .score_loaded
    lda hiscore_65
    bne .score_loaded
    lda hiscore_87
    bne .score_loaded

    jsr load_score
.score_loaded:
    lda #t_empty_id
    jsr fill_layer0
    jsr init_game_screen
    jsr refresh_hiscore
    jsr reset_objects
    lda #$FF
    sta r_obj_t
    stz r_obj_p
    stz r_obj_x
    stz r_obj_y
    jsr insert_object
    lda #$6D
    sta r_obj_x
    lda #$50
    sta r_obj_y
    jsr insert_object
    jsr sleep_one_frame
    +fn_locate 2, 2, str_title_0
    +fn_locate 2, 3, str_title_1
    +fn_locate 2, 4, str_title_2
    +fn_locate 2, 5, str_title_3
    +fn_locate 2, 6, str_title_4

    ; +fn_locate 5, 8, str_title_5
    ; +fn_locate 5, 9, str_title_6
    ; +fn_locate 5, 10, str_title_7
    ; +fn_locate 5, 11, str_title_8
    ; +fn_locate 5, 12, str_title_9

    +fn_locate 9,16, str_press_start

    +fn_plot 48, 0
    
-   lda wait_frame
    and #$01
    bne +
    jsr rng
    and #$01
    adc #$6D
    sta obj_table+6
    jsr rng
    and #$01
    adc #$50
    sta obj_table+7
+   lda #0
    jsr joystick_get        ; fetch joy0
    and #joystick_mask_start
    bne -

    ; game started
    +fn_locate 1,2, str_ui_game
    +fn_locate 1,3, str_ui_game
    +fn_locate 1,4, str_ui_game
    +fn_locate 1,5, str_ui_game
    +fn_locate 1,6, str_ui_game
    +fn_locate 0,16, str_ui_game_row

-   jsr sleep_one_frame
    dec obj_table+7
    beq +
    dec obj_table+7
    bne -
+
    ldx #$04
-   jsr sleep_one_frame
    dec obj_table+7
    dec obj_table+7
    dex
    bne -

    ldx #$3C
-   jsr sleep_one_frame
    dex
    bne -

    lda #gamemode_game_init
    sta game_mode
    jmp change_gamemode


gamemode_gameover = $FE
game_over:
    lda #t_empty_id
    jsr fill_layer0
    jsr reset_objects
    jsr sleep_one_frame
    +fn_locate 10,10,str_game_over
    ; compare hiscore with score
    lda hiscore_87          ; \
    cmp score_87            ;  |
    bcc .save_score         ;  |- compare current score
    bne +                   ;  |  with current high score
    lda hiscore_65          ;  |  
    cmp score_65            ;  |  if score is higher, 
    bcc .save_score         ;  |  save it (see .save_score)
    bne +                   ;  |  else skip the save
    lda hiscore_43          ;  |
    cmp score_43            ;  |
    bcc .save_score         ;  |
    bne +                   ;  |
    lda hiscore_21          ;  |
    cmp score_21            ;  |
    bcc .save_score         ;  |
+   jmp .gameover_sleep     ; /

.save_score:
    jsr save_score

    ldx #$3C                ; \
-   jsr sleep_one_frame     ;  |- wait 1 second
    dex                     ;  |
    bne -                   ; /
    +fn_locate 7, 12, str_new_hiscore

.gameover_sleep
    ldx #$3C                ; \
    ldy #GAMEOVER_WAIT_S    ;  |
-                           ;  |- sleeping loop
    jsr sleep_one_frame     ;  |
    dex                     ;  |
    bne -                   ;  |
    ldx #$3C                ;  |
    dey                     ;  |
    bne -                   ; /

    lda #gamemode_title     ; \
    sta game_mode           ;  |- back to title screen
    jmp change_gamemode     ; /


gamemode_game_init = $01
gamemode_game = $02
game_loop:
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
sleep_one_frame:
    lda #$FF                ; \
    sta wait_frame          ;  |- wait vsync
-   lda wait_frame          ;  |
    bne -                   ; /
    rts
; ###########################

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

backup_vera_addr:
    lda vera_high_addr
    pha
    lda vera_low_addr
    pha
    lda vera_stride_bank
    pha

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

autoscroll:
    lda scroll_speed            ; \
    beq autoscroll_done         ;  |
    tax                         ;  |- extract bit 7 - 2
    clc                         ;  |  and store into tmp var
    ror                         ;  |
    clc                         ;  |
    ror                         ;  |
    sta unsafe_addr_l           ; /
    txa                         ; \
    and #$03                    ;  |- extract bit 1-0
    beq +                       ;  |
    sta unsafe_addr_h           ; /
    and frame_count             ; \
    cmp unsafe_addr_h           ;  |- handle 1/4 movements
    bne +                       ;  |
    dec vera_layer0_vscroll_L   ; /
+   lda vera_layer0_vscroll_L   ; \
    sec                         ;  |- handle integer movements
    sbc unsafe_addr_l           ;  |
    sta vera_layer0_vscroll_L   ; /
autoscroll_done:

restore_vera_addr:
    pla
    sta vera_stride_bank
    pla
    sta vera_low_addr
    pla
    sta vera_high_addr

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

!src "movements.asm"

!src "resources/strings.asm"
!src "resources/sprites.asm"
!src "resources/tiles.asm"

*=choregraphy_start
.lvl1_start:
; insert player
!byte CHOR_OP_SBG, t_square_id
!byte CHOR_OP_SPS, $6F, $C7
!byte CHOR_OP_INS, id_mov_plyr, $00
!byte CHOR_OP_SPS, $00, $FF
!byte CHOR_OP_INS, id_mov_incr, $00
!pet CHOR_OP_CHR, 4, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 5, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 6, 4, "v"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 7, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 8, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 10, 4, "1"
!pet CHOR_OP_SLP, $10
!pet CHOR_OP_CHR, 15, 5, "f"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 16, 5, "i"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 17, 5, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 18, 5, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 19, 5, "s"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 20, 5, "y"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 21, 5, "s"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 22, 5, "t"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 23, 5, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 24, 5, "m"
!byte CHOR_OP_SOT, $01
!byte CHOR_OP_SCR, $03
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $02
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $01
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $04
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SLP, $3C
;!byte CHOR_OP_JMP, <.lvl2_start, >.lvl2_start

.lvl1_s1:
!byte CHOR_OP_LDA, $06
!byte CHOR_OP_SPS, $18, $01
.lvl1_s1_lp:
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_DEA
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JAN, <.lvl1_s1_lp, >.lvl1_s1_lp

!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $78

.lvl1_s2:
!byte CHOR_OP_SPS, $20, $20
!byte CHOR_OP_LDA, $0B

.lvl1_s2_lp:
!byte CHOR_OP_BIS, 3
    !byte id_mov_incr, $02
    !byte id_mov_incr, $12
    !byte id_mov_dcic, $12
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.lvl1_s2_lp, >.lvl1_s2_lp

.lvl1_s3:
!byte CHOR_OP_SPS, $02, $02
!byte CHOR_OP_LDA, $18

.lvl1_s3_lp:
!byte CHOR_OP_BIS, 2
    !byte id_mov_incr, $12
    !byte id_mov_incr, $22
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.lvl1_s3_lp, >.lvl1_s3_lp

.lvl1_s4:
!byte CHOR_OP_SPS, $6F, $20
!byte CHOR_OP_LDA, $08

.lvl1_s4_lp:
!byte CHOR_OP_BIS, 6
    !byte id_mov_dcic, $40
    !byte id_mov_dcic, $31
    !byte id_mov_dcic, $22
    !byte id_mov_dcic, $13
    !byte id_mov_dcic, $04
    !byte id_mov_incr, $13
!byte CHOR_OP_BIS, 6
    !byte id_mov_incr, $22
    !byte id_mov_incr, $31
    !byte id_mov_incr, $40
    !byte id_mov_decr, $40
    !byte id_mov_decr, $31
    !byte id_mov_decr, $22
!byte CHOR_OP_BIS, 6
    !byte id_mov_decr, $13
    !byte id_mov_decr, $04
    !byte id_mov_icdc, $13
    !byte id_mov_icdc, $22
    !byte id_mov_icdc, $31
    !byte id_mov_icdc, $40
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JAN, <.lvl1_s4_lp, >.lvl1_s4_lp
!byte CHOR_OP_SLP, $30

!byte CHOR_OP_LDA, $08
.lvl1_s4_blk:
!pet CHOR_OP_PRD, 2,4, "virus located", PET_NULL
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRD, 2,4, "             ", PET_NULL
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl1_s4_blk, >.lvl1_s4_blk
!byte CHOR_OP_SCR, $07

.lvl1_s5:
!byte CHOR_OP_LDA, $20
!byte CHOR_OP_SPS, $00, $01

.lvl1_s5_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $04
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.lvl1_s5_lp, >.lvl1_s5_lp

!byte CHOR_OP_SCR, $06
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $08

.lvl1_s6:
!byte CHOR_OP_LDA, $20
!byte CHOR_OP_SPS, $00, $01

.lvl1_s6_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_JAN, <.lvl1_s6_lp, >.lvl1_s6_lp

!byte CHOR_OP_SCR, $0B
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0A
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $09
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0C

.lvl1_s7:
!byte CHOR_OP_LDA, $20
!byte CHOR_OP_SPS, $00, $01

.lvl1_s7_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JAN, <.lvl1_s7_lp, >.lvl1_s7_lp

!byte CHOR_OP_SCR, $0F
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0E
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0D
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $10

.lvl1_s8:
!byte CHOR_OP_LDA, $30
!byte CHOR_OP_SPS, $00, $01

.lvl1_s8_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $0B
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_JAN, <.lvl1_s8_lp, >.lvl1_s8_lp
!byte CHOR_OP_SLP, $3C

.lvl1_boss1:
!pet CHOR_OP_PRD, 2,4, "warning", PET_NULL
!byte CHOR_OP_SCR, $0D
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0E
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0F
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $08
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRD, 2,4, "       ", PET_NULL
!byte CHOR_OP_SCR, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $06
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $07
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $04
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRD, 2,4, "warning", PET_NULL
!byte CHOR_OP_SCR, $01
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $02
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $03
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $00
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_MOB, $01, $6D, $00
!byte CHOR_OP_COB, $01, id_mov_incr, $01
!pet CHOR_OP_PRD, 2,4, "       ", PET_NULL
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_COB, $01, id_mov_incr, $00
!pet CHOR_OP_PRD, 2,4, "warning", PET_NULL
!byte CHOR_OP_SLP, $40
!pet CHOR_OP_PRD, 2,4, "       ", PET_NULL
!byte CHOR_OP_LDA, $02
!byte CHOR_OP_LDC, $10

!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COB, $01, id_mov_bcir, $00
!byte CHOR_OP_SLP, $3C
.lvl1_boss1_lp:
!byte CHOR_OP_SPR, $03, $7C, bullet_glitch1_spid
!byte CHOR_OP_SPS, $08, $10
!byte CHOR_OP_BIS, 3
    !byte id_mov_incr, $22
    !byte id_mov_incr, $31
    !byte id_mov_incr, $13
!byte CHOR_OP_SPS, $D9, $10
!byte CHOR_OP_BIS, 3
    !byte id_mov_dcic, $22
    !byte id_mov_dcic, $31
    !byte id_mov_dcic, $13
!byte CHOR_OP_SPS, $08, $60
!byte CHOR_OP_BIS, 2
    !byte id_mov_incr, $22
    !byte id_mov_icdc, $22
!byte CHOR_OP_SPS, $D9, $60
!byte CHOR_OP_BIS, 2
    !byte id_mov_dcic, $22
    !byte id_mov_decr, $22
!byte CHOR_OP_SPS, $08, $D0
!byte CHOR_OP_BIS, 3
    !byte id_mov_icdc, $22
    !byte id_mov_icdc, $31
    !byte id_mov_icdc, $13
!byte CHOR_OP_SPS, $D9, $D0
!byte CHOR_OP_BIS, 3
    !byte id_mov_decr, $22
    !byte id_mov_decr, $31
    !byte id_mov_decr, $13
!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SPS, $00, $02
.lvl1_boss1_lp2:
!byte CHOR_OP_SLP, $18
!byte CHOR_OP_SPR, $03, $7C, bullet_glitch2_spid
!byte CHOR_OP_SRX
!byte CHOR_OP_DEA
!byte CHOR_OP_DEB
!byte CHOR_OP_JAZ, <.lvl1_boss1_diag, >.lvl1_boss1_diag
!byte CHOR_OP_DEC
!byte CHOR_OP_JCZ, <.lvl1_boss1_end, >.lvl1_boss1_end 
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_JBN, <.lvl1_boss1_lp2, >.lvl1_boss1_lp2
!byte CHOR_OP_JMP, <.lvl1_boss1_lp, >.lvl1_boss1_lp
; ;;
; !byte CHOR_OP_JMP, <.lvl1_s2, >.lvl1_s2
.lvl1_boss1_diag:
!byte CHOR_OP_INS, id_mov_incr, $13
!byte CHOR_OP_INS, id_mov_dcic, $13
!byte CHOR_OP_LDA, $02
!byte CHOR_OP_JBN, <.lvl1_boss1_lp2, >.lvl1_boss1_lp2
!byte CHOR_OP_JMP, <.lvl1_boss1_lp, >.lvl1_boss1_lp

.lvl1_boss1_end:
!byte CHOR_OP_SOT, $00
!byte CHOR_OP_COB, $01, id_mov_incr, $02
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COB, $01, id_mov_rng, $00
!byte CHOR_OP_SLP, $90
!byte CHOR_OP_SPR, $02, $01, virus2_spid
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_COB, $01, id_mov_incr, $00
!byte CHOR_OP_SLP, $3C
!byte CHOR_OP_COB, $01, id_mov_decr, $02
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4,"level cleared!", PET_NULL
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,5,"bonus: 1000 pts", PET_NULL
!byte CHOR_OP_SCO, $00, $10, $00
!byte CHOR_OP_SLP, $72
!pet CHOR_OP_PRD, 2,7,"remaining: 80%", PET_NULL
!byte CHOR_OP_SLP, $72

!pet CHOR_OP_PRD, 2,4,"              ", PET_NULL
!pet CHOR_OP_PRD, 2,5,"               ", PET_NULL
!pet CHOR_OP_PRD, 2,7,"              ", PET_NULL

; --- end of lvl1
.lvl2_start:
; insert player
!byte CHOR_OP_SPR, $03, $7C, bullet_spid
!byte CHOR_OP_SPS, $00, $FF
!byte CHOR_OP_INS, id_mov_incr, $00
!pet CHOR_OP_CHR, 4, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 5, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 6, 4, "v"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 7, 4, "e"
!byte CHOR_OP_SBG, t_empty_id
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 8, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 10, 4, "2"
!pet CHOR_OP_SLP, $10
!pet CHOR_OP_CHR, 17, 5, "h"
!pet CHOR_OP_SLP, $08
!byte CHOR_OP_SBG, t_trace_id
!pet CHOR_OP_CHR, 18, 5, "i"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 19, 5, "g"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 20, 5, "h"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 21, 5, " "
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 22, 5, "r"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 23, 5, "a"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 24, 5, "m"
!byte CHOR_OP_SOT, $01
!byte CHOR_OP_SCR, $03
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $02
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $01
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $04
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SLP, $3C

!byte CHOR_OP_LDA, $05
!byte CHOR_OP_SPS, $08, $10
.lvl2_s1:
!byte CHOR_OP_LDB, $08
!byte CHOR_OP_MPS, $20, $00
.lvl2_s1_lp:
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_MPS, $00, $08
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl2_s1_lp, >.lvl2_s1_lp
!byte CHOR_OP_DEA
!byte CHOR_OP_MPS, $00, $C0
!byte CHOR_OP_JAN, <.lvl2_s1, >.lvl2_s1


!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $3C


.lvl2_s2:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_SLP, $18
!byte CHOR_OP_JMP, <.lvl2_s2, >.lvl2_s2
; ;;
; .lvl1_s2:
; !byte CHOR_OP_SPS, $6F, $20
; !byte CHOR_OP_INS, id_mov_dcic, $20
; !byte CHOR_OP_INS, id_mov_dcic, $21
; !byte CHOR_OP_INS, id_mov_dcic, $11
; !byte CHOR_OP_INS, id_mov_dcic, $12
; !byte CHOR_OP_INS, id_mov_incr, $02
; !byte CHOR_OP_INS, id_mov_incr, $12
; !byte CHOR_OP_INS, id_mov_incr, $11
; !byte CHOR_OP_INS, id_mov_incr, $21
; !byte CHOR_OP_INS, id_mov_incr, $20
; ; prepare slide loop
; !byte CHOR_OP_SPS, $20, $20
; !byte CHOR_OP_LDA, $08
; !byte CHOR_OP_SLP, $FC

; .choregraphy_slide:
; !byte CHOR_OP_INS, id_mov_incr, $02
; !byte CHOR_OP_INS, id_mov_incr, $12
; !byte CHOR_OP_INS, id_mov_dcic, $12
; !byte CHOR_OP_MPS, $10, $00
; !byte CHOR_OP_DEA
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_JAN, <.choregraphy_slide, >.choregraphy_slide
; ; next section
; !byte CHOR_OP_SLP, $30
; !byte CHOR_OP_SPS, $6F, $20
; !byte CHOR_OP_INS, id_mov_dcic, $40
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_dcic, $31
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_dcic, $22
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_dcic, $13
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_dcic, $04
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_incr, $13
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_incr, $22
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_incr, $31
; !byte CHOR_OP_SLP, $10
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_LDA, $05
; !byte CHOR_OP_SLP, $30

; .choregraphy_explosion:
; !byte CHOR_OP_INS, id_mov_dcic, $40
; !byte CHOR_OP_INS, id_mov_dcic, $31
; !byte CHOR_OP_INS, id_mov_dcic, $22
; !byte CHOR_OP_INS, id_mov_dcic, $13
; !byte CHOR_OP_INS, id_mov_dcic, $04
; !byte CHOR_OP_INS, id_mov_incr, $13
; !byte CHOR_OP_INS, id_mov_incr, $22
; !byte CHOR_OP_INS, id_mov_incr, $31
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_DEA
; !byte CHOR_OP_SLP, $08
; !byte CHOR_OP_JAN, <.choregraphy_explosion, >.choregraphy_explosion

; !byte CHOR_OP_LDA, $08
; .choregraphy_slide_explosion:
; !byte CHOR_OP_SPS, $4F, $20
; !byte CHOR_OP_INS, id_mov_incr, $04
; !byte CHOR_OP_INS, id_mov_incr, $24
; !byte CHOR_OP_INS, id_mov_dcic, $24
; !byte CHOR_OP_SPS, $8F, $20
; !byte CHOR_OP_INS, id_mov_incr, $04
; !byte CHOR_OP_INS, id_mov_incr, $24
; !byte CHOR_OP_INS, id_mov_dcic, $24
; !byte CHOR_OP_DEA
; !byte CHOR_OP_SLP, $08
; !byte CHOR_OP_JAN, <.choregraphy_slide_explosion, >.choregraphy_slide_explosion

; !byte CHOR_OP_SPS, $08, $30
; !byte CHOR_OP_INS, id_mov_incr, $10
; !byte CHOR_OP_INS, id_mov_incr, $20
; !byte CHOR_OP_INS, id_mov_incr, $30
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_INS, id_mov_incr, $50
; !byte CHOR_OP_SPS, $08, $50
; !byte CHOR_OP_INS, id_mov_incr, $10
; !byte CHOR_OP_INS, id_mov_incr, $20
; !byte CHOR_OP_INS, id_mov_incr, $30
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_INS, id_mov_incr, $50
; !byte CHOR_OP_SPS, $08, $70
; !byte CHOR_OP_INS, id_mov_incr, $10
; !byte CHOR_OP_INS, id_mov_incr, $20
; !byte CHOR_OP_INS, id_mov_incr, $30
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_INS, id_mov_incr, $50
; !byte CHOR_OP_SPS, $08, $90
; !byte CHOR_OP_INS, id_mov_incr, $10
; !byte CHOR_OP_INS, id_mov_incr, $20
; !byte CHOR_OP_INS, id_mov_incr, $30
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_INS, id_mov_incr, $50
; !byte CHOR_OP_SPS, $08, $B0
; !byte CHOR_OP_INS, id_mov_incr, $10
; !byte CHOR_OP_INS, id_mov_incr, $20
; !byte CHOR_OP_INS, id_mov_incr, $30
; !byte CHOR_OP_INS, id_mov_incr, $40
; !byte CHOR_OP_INS, id_mov_incr, $50
; !byte CHOR_OP_SPS, $D9, $30
; !byte CHOR_OP_INS, id_mov_decr, $10
; !byte CHOR_OP_INS, id_mov_decr, $20
; !byte CHOR_OP_INS, id_mov_decr, $30
; !byte CHOR_OP_INS, id_mov_decr, $40
; !byte CHOR_OP_INS, id_mov_decr, $50
; !byte CHOR_OP_SPS, $D9, $50
; !byte CHOR_OP_INS, id_mov_decr, $10
; !byte CHOR_OP_INS, id_mov_decr, $20
; !byte CHOR_OP_INS, id_mov_decr, $30
; !byte CHOR_OP_INS, id_mov_decr, $40
; !byte CHOR_OP_INS, id_mov_decr, $50
; !byte CHOR_OP_SPS, $D9, $70
; !byte CHOR_OP_INS, id_mov_decr, $10
; !byte CHOR_OP_INS, id_mov_decr, $20
; !byte CHOR_OP_INS, id_mov_decr, $30
; !byte CHOR_OP_INS, id_mov_decr, $40
; !byte CHOR_OP_INS, id_mov_decr, $50
; !byte CHOR_OP_SPS, $D9, $90
; !byte CHOR_OP_INS, id_mov_decr, $10
; !byte CHOR_OP_INS, id_mov_decr, $20
; !byte CHOR_OP_INS, id_mov_decr, $30
; !byte CHOR_OP_INS, id_mov_decr, $40
; !byte CHOR_OP_INS, id_mov_decr, $50
; !byte CHOR_OP_SPS, $D9, $B0
; !byte CHOR_OP_INS, id_mov_decr, $10
; !byte CHOR_OP_INS, id_mov_decr, $20
; !byte CHOR_OP_INS, id_mov_decr, $30
; !byte CHOR_OP_INS, id_mov_decr, $40
; !byte CHOR_OP_INS, id_mov_decr, $50

.choregraphy_end:
!byte CHOR_OP_SLP, $FF
!byte CHOR_OP_JMP, <.choregraphy_end, >.choregraphy_end

*=obj_count
!byte $00

*=obj_table

*=obj_fn_table
!word mov_null, mov_reset, mov_player, mov_inc, mov_dec, mov_inc_dec, mov_dec_inc, mov_lut_circle, mov_lut_big_circle, mov_rng
