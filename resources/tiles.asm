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


t_trace_b0_id           = .tile_id
t_trace_b0_packet_size  = .tile_size
t_trace_b0_packet_qty   = $01
t_trace_b0_bank         = vram_layer0_tilebase_b
t_trace_b0_address      = .tile_addr

t_trace_b0      !byte $00,$BC,$00,$00,$00,$00,$BC,$00
                !byte $00,$BC,$BC,$BC,$BC,$BC,$BC,$00
                !byte $00,$BC,$00,$00,$00,$00,$00,$00
                !byte $00,$BC,$00,$00,$00,$00,$00,$00
                !byte $00,$BC,$00,$BC,$BC,$BC,$BC,$00
                !byte $00,$BC,$00,$BC,$00,$00,$BC,$00
                !byte $BC,$BC,$BC,$BC,$00,$00,$BC,$BC
                !byte $00,$BC,$00,$00,$00,$00,$BC,$00
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + .tile_size

t_trace_b1_id           = .tile_id
t_trace_b1_packet_size  = .tile_size
t_trace_b1_packet_qty   = $01
t_trace_b1_bank         = vram_layer0_tilebase_b
t_trace_b1_address      = .tile_addr

t_trace_b1      !byte $00,$51,$00,$00,$00,$00,$51,$00
                !byte $00,$51,$51,$51,$51,$51,$51,$00
                !byte $00,$51,$00,$00,$00,$00,$00,$00
                !byte $00,$51,$00,$00,$00,$00,$00,$00
                !byte $00,$51,$00,$51,$51,$51,$51,$00
                !byte $00,$51,$00,$51,$00,$00,$51,$00
                !byte $51,$51,$51,$51,$00,$00,$51,$51
                !byte $00,$51,$00,$00,$00,$00,$51,$00
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + .tile_size


t_trace_b2_id           = .tile_id
t_trace_b2_packet_size  = .tile_size
t_trace_b2_packet_qty   = $01
t_trace_b2_bank         = vram_layer0_tilebase_b
t_trace_b2_address      = .tile_addr

t_trace_b2      !byte $00,$35,$00,$00,$00,$00,$35,$00
                !byte $00,$35,$35,$35,$35,$35,$35,$00
                !byte $00,$35,$00,$00,$00,$00,$00,$00
                !byte $00,$35,$00,$00,$00,$00,$00,$00
                !byte $00,$35,$00,$35,$35,$35,$35,$00
                !byte $00,$35,$00,$35,$00,$00,$35,$00
                !byte $35,$35,$35,$35,$00,$00,$35,$35
                !byte $00,$35,$00,$00,$00,$00,$35,$00
        
!set .tile_id   = .tile_id + $01
!set .tile_addr = .tile_addr + .tile_size


t_trace_gl_id           = .tile_id
t_trace_gl_packet_size  = .tile_size
t_trace_gl_packet_qty   = $01
t_trace_gl_bank         = vram_layer0_tilebase_b
t_trace_gl_address      = .tile_addr

t_trace_gl      !byte $00,$BC,$00,$00,$00,$BC,$00,$00
                !byte $00,$BC,$BC,$00,$BC,$BC,$BC,$00
                !byte $00,$BC,$00,$35,$00,$00,$00,$00
                !byte $51,$00,$00,$00,$00,$00,$00,$00
                !byte $00,$BC,$00,$BC,$35,$00,$00,$00
                !byte $00,$BC,$00,$BC,$00,$00,$51,$00
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