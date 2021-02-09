; This file serves as paperwork of the game's design
; it contains variables, explications and other neat stuff
;
; VIDEO DETAILS :
; screensize: 160x120
; Background: unused
;
; Layer 0   : map 32x32 4bpp
;       tile data: $1 0000
;       map data : $1 8000
vram_layer0_tilebase_b  = $01
vram_layer0_tilebase    = $0000
vram_layer0_mapbase_b   = $01
vram_layer0_mapbase     = $8000
;
; Layer 1   : text 32x32 1bpp
;       tile data: system default
;       map data : $0 0000
;vram_layer1_tilebase = 
vram_layer1_mapbase_b   = $00
vram_layer1_mapbase     = $0000
;
; Sprites   :
;       player : 8x16 $0 8000
vram_sprites_base_b     = $00
vram_sprites_base       = $8000
;
;
; GAME DETAILS :
; 
; 



; ADDRESSES AND STUFF
;choregraphy_start = $9000

;obj_fn_table = $9E00
obj_size =      $04
obj_idx_type =  $00
obj_idx_param = $01
obj_idx_pos_x = $02
obj_idx_pos_y = $03

; CONSTANTS
HISCORE_FILE    = $01
IO_DEVICE       = $08
IOCHECK_FILE    = $02
FILE_WRITE  = $03
FILE_READ   = $03
IOCHECK     = 15

WFRAME_MOVE = %00000001
WFRAME_CHOR = %00000010
WFRAME_MUSIC= %00000100

GRAZE_BONUS = $01
INVINCIBILITY_FRAMES = $3C
GAMEOVER_WAIT_S = $03

; LOW USAGE VARIABLES
; $0400 to $07FF
dynamic_string = $0400  ; 0~256 bytes
kernal_irq = $0500      ; 2 bytes
hiscore_87 = $0502      ; 1 byte
hiscore_65 = $0503      ; 1 byte
hiscore_43 = $0504      ; 1 byte
hiscore_21 = $0505      ; 1 byte

psg_vo_cnt   = $050F    ; 1 byte
psg_vo_note  = $0510    ; 8 bytes
psg_vo_instr = $0518    ; 8 bytes
psg_vo_delay = $0520    ; 8 bytes
psg_vo_mode = $0528     ; 8 bytes
psg_vo_deltaLo = $0530  ; 8 bytes
psg_vo_deltaHi = $0538  ; 8 bytes
psg_vo_volumeLo = $0540 ; 8 bytes
psg_vo_volumeHi = $0548 ; 8 bytes

obj_count =     $05FF   ; 1 byte
obj_table =     $0600   ; 512 bytes

; TEMPORARY VARIABLES
; $02 to $21


; VARIABLES
; $22 to $7F
unsafe_addr   = $22
unsafe_addr_l = $22
unsafe_addr_h = $23

r_obj_a  = $24 ; address
r_obj_p  = $26 ; param
r_obj_t  = $27 ; type
r_obj_x  = $28 ; x pos
r_obj_y  = $29 ; y pos
r_obj_r0 = $2A ; reg 0
r_obj_r1 = $2B ; reg 1
plyr_x   = $2C
plyr_y   = $2D
; $2E
; $2F
choregraphy_pc    = $30
choregraphy_pc_l  = $30
choregraphy_pc_h  = $31
choregraphy_pos   = $32
choregraphy_pos_l = $32
choregraphy_pos_h = $33
choregraphy_pos_x = $32
choregraphy_pos_y = $33
choregraphy_sleep = $34
choregraphy_reg_a = $35
choregraphy_reg_b = $36
choregraphy_reg_c = $37

composer_pc     = $40
composer_pc_l   = $40
composer_pc_h   = $41
composer_delay  = $42
composer_rythm  = $43
composer_sr     = $44
composer_sr_l   = $44
composer_sr_h   = $45
dividend        = $46
divisor         = $47
remainder       = $48
result          = dividend
global_volume   = $4F

score_over_time     = $73
scroll_speed        = $74
invincibility_cnt   = $75
lives               = $76
score_87            = $77
score_65            = $78
score_43            = $79
score_21            = $7A
rng_seed_0          = $7B
rng_seed_1          = $7C
wait_frame          = $7D
frame_count         = $7E
game_mode           = $7F

!macro game_video_init {

    lda #64         ; \
    sta vera_vscale ;  |- set scale
    lda #64         ;  |
    sta vera_hscale ; /

    ; configure layer 0
    +fn_vera_set_layer0_config vera_layer_config_map_width_32tiles | vera_layer_config_map_height_64tiles | vera_layer_config_color_depth_8bpp
    +fn_vera_set_layer0_tilebase $80 | vera_layer_tilebase_tile_width_8px | vera_layer_tilebase_tile_height_8px
    +fn_vera_set_layer0_mapbase (vram_layer0_mapbase_b << 7) | ((vram_layer0_mapbase >> 9) & %01111111)

    ; set video mode
    +fn_vera_set_video vera_video_mask_sprite | vera_video_mask_layer0 | vera_video_mask_layer1 | vera_video_mask_output_vga

    ; clear the text and background layers
    jsr clear_layer0
    jsr clear_layer1
    +fn_print str_white_on_black

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
}

!macro game_init {
    lda #$15        ; \
    sta rng_seed_0  ;  |- rng initialization
    lda #$84        ;  |
    sta rng_seed_1  ; /

    lda $9fbe                       ; \
	cmp #"1"                        ;  |
	bne .emu_check_end              ;  |- detect emulator's magic number
	lda $9fbf                       ;  |
	cmp #"6"                        ;  |
	bne .emu_check_end              ; /
    +fn_locate 0,2, str_emulator_msg; \_ display a message for the emulator
    jsr CHRIN                       ; /
.emu_check_end:

    ; initializes sprites
    +fn_vera_set_address $10 + vera_mem_sprite_bank, vera_mem_sprite

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
    +fn_irq_init kernal_irq, vsync_loop ; initialize vsync loop

    lda #gamemode_title                 ; \_ set gamemode to titlescreen
    sta game_mode                       ; /

    lda #63                             ; \_ init global volume
    sta global_volume                   ; /
    lda #<proto                         ; \
    sta composer_pc_l                   ;  |- TEMPORARY PLACEMENT
    lda #>proto                         ;  |  init music engine pc
    sta composer_pc_h                   ; /
    lda #$3C                            ; \
    sta composer_rythm                  ;  |- TEMPORARY PLACEMENT
    lda #$3C                            ;  |  init music engine vars
    sta composer_delay                  ; /
}