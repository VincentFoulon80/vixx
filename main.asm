is_main = 1

!src "../lib/x16.asm"
!src "../lib/irq.asm"
!src "../lib/vera.asm"
!src "../lib/math.asm"

!src "paper.asm"

!macro fn_plot .x, .y {
    phx
    phy
    ldy #.x
    ldx #.y
    clc
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
!src "components/objects.asm"
!src "components/music.asm"
!src "components/choregraphy.asm"

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

psg_upload:
    ldy #$00
    +fn_vera_set_address $10|vera_mem_psg_bank, vera_mem_psg
-   
    ldx psg_vo_note,y
    lda note_l,x
    sta vera_data_0
    lda note_h,x
    sta vera_data_0

    lda psg_vo_instr,y
    asl
    asl
    asl
    tax
    lda instrument_def + instr_idx_direction,x
    ora psg_vo_volumeHi,y
    sta vera_data_0
    lda instrument_def + instr_idx_waveform,x
    ora #$3F
    sta vera_data_0
    iny
    cpy #$08
    bne -
psg_upload_end:

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

!src "components/movements.asm"

!src "resources/strings.asm"
!src "resources/sprites.asm"
!src "resources/tiles.asm"

!src "resources/musics/sos.asm"
!src "resources/musics/proto1.asm"

choregraphy_start:
!src "resources/levels/1-filesystem.asm"
!src "resources/levels/2-high-ram.asm"


.choregraphy_end:
!byte CHOR_OP_SLP, $FF
!byte CHOR_OP_JMP, <.choregraphy_end, >.choregraphy_end


obj_fn_table:
!word mov_null, mov_reset, mov_player, mov_inc, mov_dec, mov_inc_dec, mov_dec_inc, mov_lut_circle, mov_lut_big_circle, mov_rng
