!ifndef is_main {
    !src "../../lib/vera.asm"
    !src "../paper.asm"
    *= $801
}
!set .tile_id   = $00
!set .tile_addr = vram_layer0_tilebase

t_empty_id           = $00
t_empty_packet_size  = $FF
t_empty_packet_qty   = $08
t_empty_bank         = vram_layer0_tilebase_b
t_empty_address      = .tile_addr

t_empty !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00
        !byte $00,$00,$00,$00,$00,$00,$00,$00

!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + $40


t_square_id           = $01
t_square_packet_size  = $FF
t_square_packet_qty   = $08
t_square_bank         = vram_layer0_tilebase_b
t_square_address      = .tile_addr

t_square!byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $00,$00,$00,$00,$00,$00,$00,$7B
        !byte $7B,$7B,$7B,$7B,$7B,$7B,$7B,$7B
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + $40