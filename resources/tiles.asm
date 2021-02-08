!ifndef is_main !eof

!set .tile_id   = $00
!set .tile_addr = vram_layer0_tilebase
!set .tile_size = $40

t_empty_id           = .tile_id
t_empty_packet_size  = .tile_size
t_empty_packet_qty   = $01
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
!set .tile_addr = .tile_addr + .tile_size


t_square_id           = .tile_id
t_square_packet_size  = .tile_size
t_square_packet_qty   = $01
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
!set .tile_addr = .tile_addr + .tile_size


t_trace_id           = .tile_id
t_trace_packet_size  = .tile_size
t_trace_packet_qty   = $01
t_trace_bank         = vram_layer0_tilebase_b
t_trace_address      = .tile_addr

t_trace !byte $00,$BC,$00,$00,$00,$00,$BC,$00
        !byte $00,$BC,$BC,$BC,$BC,$BC,$BC,$00
        !byte $00,$BC,$00,$00,$00,$00,$00,$00
        !byte $00,$BC,$00,$00,$00,$00,$00,$00
        !byte $00,$BC,$00,$BC,$BC,$BC,$BC,$00
        !byte $00,$BC,$00,$BC,$00,$00,$BC,$00
        !byte $BC,$BC,$BC,$BC,$00,$00,$BC,$BC
        !byte $00,$BC,$00,$00,$00,$00,$BC,$00
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + .tile_size


t_scanl_id           = .tile_id
t_scanl_packet_size  = .tile_size
t_scanl_packet_qty   = $01
t_scanl_bank         = vram_layer0_tilebase_b
t_scanl_address      = .tile_addr

t_scanl !byte $10,$10,$10,$10,$10,$10,$10,$10
        !byte $11,$11,$11,$11,$11,$11,$11,$11
        !byte $12,$12,$12,$12,$12,$12,$12,$12
        !byte $13,$13,$13,$13,$13,$13,$13,$13
        !byte $14,$14,$14,$14,$14,$14,$14,$14
        !byte $13,$13,$13,$13,$13,$13,$13,$13
        !byte $12,$12,$12,$12,$12,$12,$12,$12
        !byte $11,$11,$11,$11,$11,$11,$11,$11
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + .tile_size