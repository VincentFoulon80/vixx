!ifndef is_main !eof

!set .sprite_addr = vram_sprites_base
!set .sprite_size = $20


bullet_packet_size  = .sprite_size
bullet_packet_qty   = $01
bullet_bank         = vram_sprites_base_b
bullet_address      = .sprite_addr
bullet_spid         = <(bullet_address >> 5)
bullet_spid_size    = vera_sprite_width_8px | vera_sprite_height_8px
bullet_spid_def     = vera_sprite_mode_4bpp + (bullet_bank << 3) + (bullet_address >> 13)

bullet  !byte $00,$00,$00,$00
        !byte $00,$0A,$A0,$00
        !byte $00,$A1,$1A,$00
        !byte $0A,$11,$11,$A0
        !byte $0A,$11,$11,$A0
        !byte $00,$A1,$1A,$00
        !byte $00,$0A,$A0,$00
        !byte $00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size

bullet_glitch1_packet_size  = .sprite_size
bullet_glitch1_packet_qty   = $01
bullet_glitch1_bank         = vram_sprites_base_b
bullet_glitch1_address      = .sprite_addr
bullet_glitch1_spid         = <(bullet_glitch1_address >> 5)
bullet_glitch1_spid_size    = vera_sprite_width_8px | vera_sprite_height_8px
bullet_glitch1_spid_def     = vera_sprite_mode_4bpp + (bullet_glitch1_bank << 3) + (bullet_glitch1_address >> 13)

bullet_glitch1   !byte $00,$00,$00,$00
                 !byte $0A,$A0,$00,$00
                 !byte $00,$0A,$11,$A0
                 !byte $0A,$11,$11,$A0
                 !byte $A1,$11,$1A,$00
                 !byte $00,$A1,$1A,$00
                 !byte $00,$00,$00,$AA
                 !byte $00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size


bullet_glitch2_packet_size  = .sprite_size
bullet_glitch2_packet_qty   = $01
bullet_glitch2_bank         = vram_sprites_base_b
bullet_glitch2_address      = .sprite_addr
bullet_glitch2_spid         = <(bullet_glitch2_address >> 5)
bullet_glitch2_spid_size    = vera_sprite_width_8px | vera_sprite_height_8px
bullet_glitch2_spid_def     = vera_sprite_mode_4bpp + (bullet_glitch2_bank << 3) + (bullet_glitch2_address >> 13)

bullet_glitch2   !byte $0A,$00,$00,$00
                 !byte $0A,$0A,$0A,$00
                 !byte $00,$01,$A1,$00
                 !byte $00,$01,$11,$00
                 !byte $00,$A1,$1A,$A0
                 !byte $00,$A1,$10,$A0
                 !byte $00,$1A,$10,$00
                 !byte $00,$A0,$A0,$00

!set .sprite_addr = .sprite_addr + .sprite_size


player_packet_size  = .sprite_size
player_packet_qty   = $01
player_bank         = vram_sprites_base_b
player_address      = .sprite_addr
player_spid         = <(player_address >> 5)
player_spid_size    = vera_sprite_width_8px | vera_sprite_height_8px
player_spid_def     = vera_sprite_mode_4bpp + (player_bank << 3) + (player_address >> 13)
player  !byte $00,$0D,$D0,$00
        !byte $00,$0D,$D0,$00
        !byte $D0,$0D,$D0,$0D
        !byte $D0,$DD,$DD,$0D
        !byte $D5,$DD,$DD,$5D
        !byte $D5,$DD,$DD,$5D
        !byte $D5,$DD,$DD,$5D
        !byte $D0,$DD,$DD,$0D

!set .sprite_addr = .sprite_addr + .sprite_size



touched_player_packet_size  = .sprite_size
touched_player_packet_qty   = $01
touched_player_bank         = vram_sprites_base_b
touched_player_address      = .sprite_addr
touched_player_spid         = <(touched_player_address >> 5)
touched_player_spid_size    = vera_sprite_width_8px | vera_sprite_height_8px
touched_player_spid_def     = vera_sprite_mode_4bpp + (touched_player_bank << 3) + (touched_player_address >> 13)
touched_player  !byte $00,$0A,$A0,$00
                !byte $00,$0A,$A0,$00
                !byte $A0,$0A,$A0,$0A
                !byte $A0,$AA,$AA,$0A
                !byte $A2,$AA,$AA,$2A
                !byte $A2,$AA,$AA,$2A
                !byte $A2,$AA,$AA,$2A
                !byte $A0,$AA,$AA,$0A

!set .sprite_addr = .sprite_addr + .sprite_size

virus1_packet_size  = .sprite_size*4
virus1_packet_qty   = $01
virus1_bank         = vram_sprites_base_b
virus1_address      = .sprite_addr
virus1_spid         = <(virus1_address >> 5)
virus1_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus1_spid_def     = vera_sprite_mode_4bpp + (virus1_bank << 3) + (virus1_address >> 13)
virus1   !byte $22,$22,$22,$22,$22,$22,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$AA,$20,$00
        !byte $2A,$22,$2A,$2A,$22,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$22,$2A,$2A,$22,$2A,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$AA,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$AA,$20,$00
        !byte $22,$22,$22,$22,$22,$22,$20,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4

virus2_packet_size  = .sprite_size*4
virus2_packet_qty   = $01
virus2_bank         = vram_sprites_base_b
virus2_address      = .sprite_addr
virus2_spid         = <(virus2_address >> 5)
virus2_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus2_spid_def     = vera_sprite_mode_4bpp + (virus2_bank << 3) + (virus2_address >> 13)
virus2  !byte $22,$22,$22,$22,$22,$22,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$A2,$00,$00
        !byte $2A,$22,$2A,$2A,$22,$2A,$22,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$22,$2A,$2A,$22,$2A,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$A2,$00,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$22,$00,$00
        !byte $2A,$2A,$2A,$2A,$2A,$2A,$20,$00
        !byte $2A,$AA,$AA,$AA,$AA,$A2,$00,$00
        !byte $22,$22,$22,$22,$22,$22,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$20,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4

virus3_packet_size  = .sprite_size*4
virus3_packet_qty   = $01
virus3_bank         = vram_sprites_base_b
virus3_address      = .sprite_addr
virus3_spid         = <(virus3_address >> 5)
virus3_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus3_spid_def     = vera_sprite_mode_4bpp + (virus3_bank << 3) + (virus3_address >> 13)
virus3  !byte $22,$22,$22,$22,$20,$02,$20,$00
        !byte $2A,$AA,$AA,$AA,$A2,$02,$00,$00
        !byte $2A,$22,$2A,$2A,$22,$00,$22,$00
        !byte $2A,$2A,$2A,$2A,$2A,$22,$20,$00
        !byte $2A,$2A,$2A,$2A,$22,$02,$20,$00
        !byte $2A,$22,$2A,$2A,$22,$22,$20,$00
        !byte $2A,$AA,$AA,$AA,$A2,$00,$00,$00
        !byte $2A,$2A,$2A,$2A,$22,$02,$20,$00
        !byte $2A,$2A,$2A,$2A,$22,$00,$20,$00
        !byte $2A,$2A,$2A,$2A,$2A,$20,$00,$00
        !byte $2A,$2A,$2A,$2A,$2A,$20,$20,$00
        !byte $2A,$AA,$AA,$AA,$A2,$02,$00,$00
        !byte $22,$22,$22,$22,$20,$02,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$20,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4

virus4_packet_size  = .sprite_size*4
virus4_packet_qty   = $01
virus4_bank         = vram_sprites_base_b
virus4_address      = .sprite_addr
virus4_spid         = <(virus4_address >> 5)
virus4_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus4_spid_def     = vera_sprite_mode_4bpp + (virus4_bank << 3) + (virus4_address >> 13)
virus4  !byte $22,$22,$22,$22,$20,$00,$00,$00
        !byte $2A,$AA,$AA,$AA,$A2,$02,$00,$00
        !byte $2A,$22,$2A,$22,$22,$00,$22,$00
        !byte $2A,$2A,$2A,$20,$02,$02,$00,$00
        !byte $2A,$2A,$2A,$20,$00,$00,$00,$00
        !byte $2A,$22,$2A,$20,$02,$00,$20,$00
        !byte $2A,$AA,$AA,$A2,$02,$00,$00,$00
        !byte $2A,$2A,$2A,$2A,$22,$00,$20,$00
        !byte $2A,$2A,$2A,$2A,$20,$02,$00,$00
        !byte $2A,$2A,$2A,$2A,$20,$00,$00,$00
        !byte $2A,$2A,$2A,$22,$00,$20,$00,$00
        !byte $2A,$AA,$A2,$00,$00,$00,$00,$00
        !byte $22,$22,$22,$22,$20,$00,$00,$00
        !byte $00,$00,$00,$22,$00,$00,$20,$00
        !byte $00,$00,$00,$00,$02,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4

virus5_packet_size  = .sprite_size*4
virus5_packet_qty   = $01
virus5_bank         = vram_sprites_base_b
virus5_address      = .sprite_addr
virus5_spid         = <(virus5_address >> 5)
virus5_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus5_spid_def     = vera_sprite_mode_4bpp + (virus5_bank << 3) + (virus5_address >> 13)
virus5  !byte $22,$22,$22,$22,$00,$00,$00,$00
        !byte $2A,$AA,$A2,$20,$02,$00,$00,$00
        !byte $2A,$22,$20,$00,$00,$00,$00,$00
        !byte $2A,$2A,$20,$20,$00,$00,$00,$00
        !byte $2A,$2A,$22,$20,$00,$00,$00,$00
        !byte $2A,$22,$2A,$20,$00,$00,$00,$00
        !byte $2A,$AA,$AA,$22,$00,$00,$00,$00
        !byte $2A,$2A,$2A,$2A,$22,$00,$00,$00
        !byte $2A,$2A,$2A,$22,$20,$00,$00,$00
        !byte $22,$2A,$22,$00,$00,$00,$00,$00
        !byte $20,$02,$20,$00,$00,$20,$00,$00
        !byte $00,$00,$02,$00,$00,$00,$00,$00
        !byte $02,$22,$00,$02,$20,$00,$00,$00
        !byte $00,$00,$00,$02,$00,$00,$20,$00
        !byte $00,$20,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4

virus6_packet_size  = .sprite_size*4
virus6_packet_qty   = $01
virus6_bank         = vram_sprites_base_b
virus6_address      = .sprite_addr
virus6_spid         = <(virus6_address >> 5)
virus6_spid_size    = vera_sprite_width_16px | vera_sprite_height_16px
virus6_spid_def     = vera_sprite_mode_4bpp + (virus6_bank << 3) + (virus6_address >> 13)
virus6  !byte $02,$02,$22,$22,$00,$00,$00,$00
        !byte $00,$00,$00,$20,$00,$00,$00,$00
        !byte $20,$22,$20,$00,$00,$00,$00,$00
        !byte $20,$02,$20,$20,$00,$00,$00,$00
        !byte $22,$02,$22,$20,$00,$00,$00,$00
        !byte $02,$00,$2A,$20,$00,$00,$00,$00
        !byte $22,$00,$2A,$22,$00,$00,$00,$00
        !byte $00,$22,$2A,$2A,$22,$00,$00,$00
        !byte $00,$02,$2A,$22,$20,$00,$00,$00
        !byte $20,$02,$22,$00,$00,$00,$00,$00
        !byte $20,$02,$20,$00,$00,$00,$00,$00
        !byte $00,$00,$02,$00,$00,$00,$00,$00
        !byte $02,$22,$00,$02,$20,$00,$00,$00
        !byte $00,$00,$00,$02,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .sprite_addr = .sprite_addr + .sprite_size*4