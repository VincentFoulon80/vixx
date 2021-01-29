!ifndef is_main {
    !src "../../lib/vera.asm"
    !src "../paper.asm"
    *= $801
}

!set .sprite_addr = vram_sprites_base


bullet_packet_size  = $FF
bullet_packet_qty   = $08
bullet_bank         = vram_sprites_base_b
bullet_address      = .sprite_addr
bullet_spid         = <(bullet_address >> 5)
bullet_spid_def     = vera_sprite_mode_4bpp + (bullet_bank << 3) + (bullet_address >> 13)

bullet  !byte $00,$00,$00,$00
        !byte $00,$0A,$A0,$00
        !byte $00,$A1,$1A,$00
        !byte $0A,$11,$11,$A0
        !byte $0A,$11,$11,$A0
        !byte $00,$A1,$1A,$00
        !byte $00,$0A,$A0,$00
        !byte $00,$00,$00,$00

!set .sprite_addr = .sprite_addr + $20


player_packet_size  = $FF
player_packet_qty   = $08
player_bank         = vram_sprites_base_b
player_address      = .sprite_addr
player_spid         = <(player_address >> 5)
player_spid_def     = vera_sprite_mode_4bpp + (player_bank << 3) + (player_address >> 13)
player  !byte $00,$0D,$D0,$00
        !byte $00,$0D,$D0,$00
        !byte $D0,$0D,$D0,$0D
        !byte $D0,$DD,$DD,$0D
        !byte $D5,$DD,$DD,$5D
        !byte $D5,$DD,$DD,$5D
        !byte $D5,$DD,$DD,$5D
        !byte $D0,$DD,$DD,$0D

!set .sprite_addr = .sprite_addr + $20



touched_player_packet_size  = $FF
touched_player_packet_qty   = $08
touched_player_bank         = vram_sprites_base_b
touched_player_address      = .sprite_addr
touched_player_spid         = <(touched_player_address >> 5)
touched_player_spid_def     = vera_sprite_mode_4bpp + (touched_player_bank << 3) + (touched_player_address >> 13)
touched_player  !byte $00,$0A,$A0,$00
                !byte $00,$0A,$A0,$00
                !byte $A0,$0A,$A0,$0A
                !byte $A0,$AA,$AA,$0A
                !byte $A2,$AA,$AA,$2A
                !byte $A2,$AA,$AA,$2A
                !byte $A2,$AA,$AA,$2A
                !byte $A0,$AA,$AA,$0A

!set .sprite_addr = .sprite_addr + $20