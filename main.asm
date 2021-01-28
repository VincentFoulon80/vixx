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
-                                                       ; \
    lda #<$0400                                         ;  |  
    sta vera_data_0 ; addr_mode                         ;  |- init all sprites
    lda #>$0400                                         ;  |
    sta vera_data_0 ; addr_mode                         ;  |
    stz vera_data_0 ; pos x (low)                       ;  |
    stz vera_data_0 ; pos x (high)                      ;  |
    stz vera_data_0 ; pos y (low)                       ;  |
    stz vera_data_0 ; pos y (high)                      ;  |
                                                        ;  |
    lda #vera_sprite_zdepth_behind_layer1               ;  |
    sta vera_data_0                                     ;  |
    lda #vera_sprite_width_8px | vera_sprite_height_8px ;  |
    sta vera_data_0                                     ;  |
                                                        ;  |
    dex                                                 ;  |
    bne -                                               ; /

    +fn_vera_set_video vera_video_mask_sprite | vera_video_mask_layer1 | vera_video_mask_output_vga
    jsr clear_layer0
    jsr clear_layer1

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

.load_score
    ; LOAD SCORE
    lda #HISCORE_FILE       ; \
    ldx #HISCORE_DEVICE     ;  |- prepare logical file
    ldy #FILE_READ          ;  |
    jsr SETLFS              ; /
    lda #file_hiscore_len   ; \  )- size of filename
    ldx #<file_hiscore_r    ;  | )- address of
    ldy #>file_hiscore_r    ;  | )- file name
    jsr SETNAM              ; /  )- set filename
    jsr OPEN                ; )- open file
    bcc +                   ; \
-   stz hiscore_87          ;  |
    stz hiscore_65          ;  |- if error we set a default value else we continue
    stz hiscore_43          ;  |
    stz hiscore_21          ;  |
    lda #HISCORE_FILE       ;  |
    jsr CLOSE               ;  |
    jsr CLRCHN              ;  |
    jmp .score_loaded       ;  |
+                           ; /
    ldx #HISCORE_FILE       ; \_ set file as current channel
    jsr CHKIN               ; /
    jsr GETIN               ; \_ get first byte
    sta hiscore_87          ; /
    jsr READST              ; \
    AND #$40                ;  |- verify that the file exists
    bne -                   ; /
    jsr GETIN               ; \
    sta hiscore_65          ;  |
    jsr GETIN               ;  |- load the rest of the score
    sta hiscore_43          ;  |
    jsr GETIN               ;  |
    sta hiscore_21          ; /
    lda #HISCORE_FILE       ; \
    jsr CLOSE               ;  |- close the file and reset channels
    jsr CLRCHN              ; /

.score_loaded
    
    jsr init_game_screen
    jsr refresh_hiscore
    jsr reset_objects
    jsr sleep_one_frame
    +fn_locate 9,10,str_press_enter

    jsr CHRIN                       ; wait for the enter key

    +fn_locate 0,10, str_ui_game_row
    lda #gamemode_game_init
    sta game_mode
    jmp change_gamemode


gamemode_gameover = $FE
game_over:
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

.save_score
    lda score_87            ; \
    sta hiscore_87          ;  |
    lda score_65            ;  |- transfer score
    sta hiscore_65          ;  |  to high score
    lda score_43            ;  |
    sta hiscore_43          ;  |
    lda score_21            ;  |
    sta hiscore_21          ; /
    lda #HISCORE_FILE       ; \
    ldx #HISCORE_DEVICE     ;  |- prepare logical file
    ldy #FILE_WRITE         ;  |
    jsr SETLFS              ; /
    lda #file_hiscore_len+2 ; \  )- size of filename
    ldx #<file_hiscore_w    ;  | )- address of
    ldy #>file_hiscore_w    ;  | )- file name
    jsr SETNAM              ; /  )- set filename
    jsr OPEN                ; )- open file
    bcc +                   ; \
    lda #HISCORE_FILE       ;  |
    jsr CLOSE               ;  |- if error we skip
    jsr CLRCHN              ;  |
    jmp .score_saved        ;  |
+                           ; /
    ldx #HISCORE_FILE       ; \_ set file as current channel
    jsr CHKOUT              ; /
    lda score_87            ; \
    jsr CHROUT              ;  |
    jsr READST
    lda score_65            ;  |- write score
    jsr CHROUT              ;  |
    lda score_43            ;  |
    jsr CHROUT              ;  |
    lda score_21            ;  |
    jsr CHROUT              ; /
    lda #HISCORE_FILE       ; \
    jsr CLOSE               ;  |- close the file and reset channels
    jsr CLRCHN              ; /
.score_saved
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
.lol
!byte CHOR_OP_SPS, $08, $10
!byte CHOR_OP_INS, id_mov_incr, $22
!byte CHOR_OP_INS, id_mov_incr, $31
!byte CHOR_OP_INS, id_mov_incr, $13
!byte CHOR_OP_SPS, $D9, $10
!byte CHOR_OP_INS, id_mov_dcic, $22
!byte CHOR_OP_INS, id_mov_dcic, $31
!byte CHOR_OP_INS, id_mov_dcic, $13
!byte CHOR_OP_SPS, $08, $60
!byte CHOR_OP_INS, id_mov_incr, $22
!byte CHOR_OP_INS, id_mov_icdc, $22
!byte CHOR_OP_SPS, $D9, $60
!byte CHOR_OP_INS, id_mov_dcic, $22
!byte CHOR_OP_INS, id_mov_decr, $22
!byte CHOR_OP_SPS, $08, $D0
!byte CHOR_OP_INS, id_mov_icdc, $22
!byte CHOR_OP_INS, id_mov_icdc, $31
!byte CHOR_OP_INS, id_mov_icdc, $13
!byte CHOR_OP_SPS, $D9, $D0
!byte CHOR_OP_INS, id_mov_decr, $22
!byte CHOR_OP_INS, id_mov_decr, $31
!byte CHOR_OP_INS, id_mov_decr, $13
!byte CHOR_OP_SLP, $1A
!byte CHOR_OP_JMP, <.lol, >.lol
;;
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


*=obj_fn_table
!word mov_null, mov_reset, mov_player, mov_inc, mov_dec, mov_inc_dec, mov_dec_inc;, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg, mov_dbg
; note : mov_null doit rien faire, et ajouter un mov_reset pour forcer la position