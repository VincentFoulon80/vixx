vera_low_addr   = $9F20
vera_high_addr  = $9F21
vera_stride_bank= $9F22

vera_data_0 = $9F23
vera_data_1 = $9F24
vera_ctrl   = $9F25

vera_isr_mask_collisions= %11110000
vera_isr_mask_aflow     = %00001000
vera_isr_mask_sprcol    = %00000100
vera_isr_mask_line      = %00000010
vera_isr_mask_vsync     = %00000001
vera_ien    = $9F26
vera_isr    = $9F27
vera_irqline= $9F28
; if DCSEL == 0 
vera_video  = $9F29
vera_hscale = $9F2A
vera_vscale = $9F2B
vera_border = $9F2C
; else if DCSEL == 1
vera_hstart = $9F29
vera_hstop  = $9F2A
vera_vstart = $9F2B
vera_vstop  = $9F2C
; end

vera_layer0_config      = $9F2D
vera_layer0_mapbase     = $9F2E
vera_layer0_tilebase    = $9F2F
vera_layer0_hscroll_L   = $9F30
vera_layer0_hscroll_H   = $9F31
vera_layer0_vscroll_L   = $9F32
vera_layer0_vscroll_H   = $9F33

vera_layer1_config      = $9F34
vera_layer1_mapbase     = $9F35
vera_layer1_tilebase    = $9F36
vera_layer1_hscroll_L   = $9F37
vera_layer1_hscroll_H   = $9F38
vera_layer1_vscroll_L   = $9F39
vera_layer1_vscroll_H   = $9F3A

vera_audio_ctrl = $9F3B
vera_audio_rate = $9F3C
vera_audio_data = $9F3D

vera_spi_data = $9F3E
vera_spi_ctrl = $9F3F

; ########################################################
; ### MEMORY MAP #########################################
; ########################################################

vera_mem_vram_bank  = $00
vera_mem_vram       = $0000
vera_mem_psg_bank   = $01
vera_mem_psg        = $F9C0
vera_mem_palette_bank=$01 
vera_mem_palette    = $FA00
vera_mem_sprite_bank= $01
vera_mem_sprite     = $FC00

; ########################################################
; ### INITIALIZATION #####################################
; ########################################################

; insert subroutines into your code
; you need to run this macro once to enable features of this file
!macro fn_vera_init_subroutines {
    jmp vera_sr_end

; @see !macro fn_vera_upload
; params:
;     x = chunk quantity to upload
;     VERA_UPLOAD_ZP_ADDR = address to upload
;     VERA_UPLOAD_ZP_SIZE = chunk size
; alter:
;     a = last addr low byte
;     x = 0
;     y = 0
vera_sr_upload:
    ldy VERA_UPLOAD_ZP_SIZE        ; )- init y
-       lda (VERA_UPLOAD_ZP_ADDR)   ; \_ copy byte to vera
        sta vera_data_0             ; /
        inc VERA_UPLOAD_ZP_ADDR     ; \
        bne +                       ;  |- inc16 upload_addr
        inc VERA_UPLOAD_ZP_ADDR+1   ; /
+       dey                         ; \_ loop until y == 0
        bne -                       ; /
        dex                         ; \_ loop and reset y until x == 0
        bne vera_sr_upload          ; /
    rts                             ; )- end of upload

vera_sr_end:
}
; end of fn_vera_init_subroutines


; ########################################################
; ### CONTROL ############################################
; ########################################################


vera_ctrl_mask_reset  = %10000000
vera_ctrl_mask_dcsel  = %00000010
vera_ctrl_mask_addrsel= %00000001
!macro fn_vera_set_ctrl .value {
    lda #.value
    sta vera_ctrl
}

vera_video_mask_current= %10000000
vera_video_mask_sprite = %01000000
vera_video_mask_layer1 = %00100000
vera_video_mask_layer0 = %00010000
vera_video_mask_chroma = %00000100
vera_video_mask_output_vga  = %00000001
vera_video_mask_output_ntsc = %00000010
vera_video_mask_output_rgb  = %00000011
!macro fn_vera_video_enable .mask {
    +fn_vera_set_ctrl 0
    lda vera_video
    ora #.mask
    sta vera_video
}
!macro fn_vera_video_disable .mask {
    +fn_vera_set_ctrl 0
    lda vera_video
    and #!.mask
    sta vera_video
}
!macro fn_vera_set_video .value {
    +fn_vera_set_ctrl 0
    lda #.value
    sta vera_video
}


; ########################################################
; ### LAYERS #############################################
; ########################################################


vera_layer_config_map_height_32tiles = %00000000
vera_layer_config_map_height_64tiles = %01000000
vera_layer_config_map_height_128tiles= %10000000
vera_layer_config_map_height_256tiles= %11000000
vera_layer_config_map_width_32tiles  = %00000000
vera_layer_config_map_width_64tiles  = %00010000
vera_layer_config_map_width_128tiles = %00100000
vera_layer_config_map_width_256tiles = %00110000
vera_layer_config_t256c              = %00001000
vera_layer_config_bitmap             = %00000100
vera_layer_config_color_depth_1bpp   = %00000000
vera_layer_config_color_depth_2bpp   = %00000001
vera_layer_config_color_depth_4bpp   = %00000010
vera_layer_config_color_depth_8bpp   = %00000011
!macro fn_vera_set_layer0_config .config {
    lda #.config
    sta vera_layer0_config
}
!macro fn_vera_set_layer1_config .config {
    lda #.config
    sta vera_layer1_config
}

!macro fn_vera_set_layer0_mapbase .mapbase {
    lda #.mapbase
    sta vera_layer0_mapbase
}
!macro fn_vera_set_layer1_mapbase .mapbase {
    lda #.mapbase
    sta vera_layer1_mapbase
}

vera_layer_tilebase_tile_height_8px = %00000000
vera_layer_tilebase_tile_height_16px= %00000010
vera_layer_tilebase_tile_width_8px  = %00000000
vera_layer_tilebase_tile_width_16px = %00000001
!macro fn_vera_set_layer0_tilebase .tilebase {
    lda #.tilebase
    sta vera_layer0_tilebase
}
!macro fn_vera_set_layer1_tilebase .tilebase {
    lda #.tilebase
    sta vera_layer1_tilebase
}


; ########################################################
; ### FUNCTIONS ##########################################
; ########################################################

; Set the provided adress to Vera
; params:
;     8b  stride_bank: %iiiis--b
;          i = increment value, as a power of 2
;          s = increment's sign (neg = 1)
;          b = bank
;     16b address: Address to set
!macro fn_vera_set_address .stride_bank, .address {
    lda #.stride_bank
    sta vera_stride_bank
    lda #<.address
    sta vera_low_addr
    lda #>.address
    sta vera_high_addr
}
!macro fn_vera_set_address_1 .stride_bank, .address {
    +fn_vera_set_ctrl vera_ctrl_mask_addrsel
    lda #.stride_bank
    sta vera_stride_bank
    lda #<.address
    sta vera_low_addr
    lda #>.address
    sta vera_high_addr
    +fn_vera_set_ctrl 0
}

; Register a sprite into Vera's VRAM
; params:
;     8b  index: sprite index
;     16b addr_mode: $MAAA
;          M = %m--- (three bits are unused)
;          AAA = address from bit 16 to bit 5 (you need to shift the actual address by 5 on the right)
;     16b position_x/y: sprite position on screen
;     8b  collision_flip: %cccczzvh 
;          c = collision mask
;          z = z depth
;          v/h = vertical or horizontal flip
vera_sprite_mode_4bpp = %00000000
vera_sprite_mode_8bpp = %10000000
vera_sprite_zdepth_disabled     = %00000000
vera_sprite_zdepth_behind_layer0= %00000100
vera_sprite_zdepth_behind_layer1= %00001000
vera_sprite_zdepth_above_layer1 = %00001100
vera_sprite_flip_v  = %00000010
vera_sprite_flip_h  = %00000001
vera_sprite_width_8px  = %00000000
vera_sprite_width_16px = %00010000
vera_sprite_width_32px = %00100000
vera_sprite_width_64px = %00110000
vera_sprite_height_8px = %00000000
vera_sprite_height_16px= %01000000
vera_sprite_height_32px= %10000000
vera_sprite_height_64px= %11000000
!macro fn_vera_register_sprite .index, .addr_mode, .position_x, .position_y, .collision_flip, .size_palette  {
    +fn_vera_set_address %00010001, ($FC00+(.index*8)) ; increment 1, bank 1, address FC00 + index*8
    lda #<.addr_mode
    sta vera_data_0
    lda #>.addr_mode
    sta vera_data_0

    lda #<.position_x
    sta vera_data_0
    lda #>.position_x
    sta vera_data_0

    lda #<.position_y
    sta vera_data_0
    lda #>.position_y
    sta vera_data_0

    lda #.collision_flip
    sta vera_data_0
    lda #.size_palette
    sta vera_data_0
}

; Change the x position of a sprite with the x and y registers
; params:
;     8b .index: sprite index
;     16b XXYY: new x position
;         X = X register (hi)
;         Y = Y register (lo)
!macro fn_vera_update_sprite_x .index {
    +fn_vera_set_address %00010001, ($FC02+(.index*8)) ; increment 1, bank 1, address FC02 + index*8
    sty vera_data_0
    stx vera_data_0
}
; Change the y position of a sprite with the x and y registers
; params:
;     8b .index: sprite index
;     16b XXYY: new y position
;         X = X register (hi)
;         Y = Y register (lo)
!macro fn_vera_update_sprite_y .index {
    +fn_vera_set_address %00010001, ($FC04+(.index*8)) ; increment 1, bank 1, address FC04 + index*8
    sty vera_data_0
    stx vera_data_0
}


!macro fn_vera_upload_set_data_addr .data_addr {
    lda #<.data_addr
    sta VERA_UPLOAD_ZP_ADDR
    lda #>.data_addr
    sta VERA_UPLOAD_ZP_ADDR+1
}

; Uploads data to Vera at a specified location
; params:
;     16b data_addr: location of the data to upload
;     8b  vera_stride: %iiiis--b
;          i = increment value, as a power of 2
;          s = increment's sign (neg = 1)
;          b = bank
;     16b vera_addr: starting position in Vera's address space
;     8b  chunk_size: Size of a packet+1
;     8b  chunk_qty: how many packets to send
!macro fn_vera_upload .data_addr, .vera_stride, .vera_addr, .chunk_size, .chunk_qty {
    ; setup target address
    +fn_vera_set_address .vera_stride, .vera_addr
    +fn_vera_direct_upload .data_addr, .chunk_size, .chunk_qty
}

; uploads data to Vera without changing the target address
; @see !macro fn_vera_upload
VERA_UPLOAD_ZP_ADDR = $02
VERA_UPLOAD_ZP_SIZE = $04
!macro fn_vera_direct_upload .data_addr, .chunk_size, .chunk_qty {
    ; setup data address
    +fn_vera_upload_set_data_addr .data_addr
    ; setup chunk sizes
    lda #.chunk_size
    sta VERA_UPLOAD_ZP_SIZE
    ; setup subroutine
    ldx #.chunk_qty
    jsr vera_sr_upload
}

; Uploads data to Vera at current location
; params:
;     16b data_addr: location of the data to upload
;     8b  chunk_size: Size of a packet+1
; alter:
;     a = last byte uploaded
;     x = 0
;     y = size of chunk
!macro fn_vera_upload_simple .data_addr, .chunk_size {
    ldx .chunk_size
    ldy #0
-       lda (.data_addr),Y
        sta vera_data_0
        iny
        dex
        bne -
    rts
}

vera_psg_left   = %01000000
vera_psg_right  = %10000000
vera_psg_volume = %00111111
vera_psg_waveform_pulse     = %00000000
vera_psg_waveform_sawtooth  = %01000000
vera_psg_waveform_triangle  = %10000000
vera_psg_waveform_noise     = %11000000
vera_psg_waveform_length    = %00111111

vera_audio_mask_fifo        = %10000000
vera_audio_mask_16bit       = %00100000
vera_audio_mask_stereo      = %00010000
vera_audio_mask_pcm_volume  = %00001111