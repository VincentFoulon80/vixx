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
; $0400 to $07FF
kernal_irq = $9EFE

choregraphy_start = $9000

obj_fn_table = $9E00
obj_count =     $9BFF
obj_table =     $9C00
obj_size =      $04
obj_idx_type =  $00
obj_idx_param = $01
obj_idx_pos_x = $02
obj_idx_pos_y = $03

dynamic_string = $0400

; CONSTANTS
WFRAME_MOVE = %00000001
WFRAME_CHOR = %00000010

GRAZE_BONUS = $01

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
choregraphy_mode  = $32
choregraphy_pos   = $33
choregraphy_pos_l = $33
choregraphy_pos_h = $34
choregraphy_pos_x = $33
choregraphy_pos_y = $34
choregraphy_sleep = $35
choregraphy_reg_a = $36
choregraphy_reg_b = $37

score_87 = $77
score_65 = $78
score_43 = $79
score_21 = $7A
rng_seed_0 = $7B
rng_seed_1 = $7C
wait_frame = $7D
frame_count = $7E
game_mode = $7F

!macro game_video_init {
;    .layer0_mapbase = ((vram_layer0_mapbase_b <<< 16) + vram_layer0_mapbase) >>> 9
;    .layer0_tilebase = (vram_layer0_tilebase_b <<< 16) >>> 9

    ; setup map layer
;    +fn_vera_set_layer0_config vera_layer_config_map_width_32tiles | vera_layer_config_map_height_32tiles | vera_layer_config_color_depth_4bpp
;    +fn_vera_set_layer0_tilebase .layer0_tilebase | vera_layer_tilebase_tile_height_16px | vera_layer_tilebase_tile_width_16px
;    +fn_vera_set_layer0_mapbase .layer0_mapbase
    ; setup text layer
;    +fn_vera_set_layer1_config vera_layer_config_map_width_32tiles | vera_layer_config_map_height_32tiles | vera_layer_config_color_depth_1bpp

    lda #64
    sta vera_vscale
    lda #64
    sta vera_hscale
    +fn_print str_white_on_black
}

!macro game_init {
    stz game_mode
    lda #$15
    sta rng_seed_0
    lda #$84
    sta rng_seed_1
    lda #<choregraphy_start
    sta choregraphy_pc_l
    lda #>choregraphy_start
    sta choregraphy_pc_h
}