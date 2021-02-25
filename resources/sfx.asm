!ifndef is_main !eof

; byte order:
;   sfx_duration
;   sfx_freq_l
;   sfx_freq_h
;   sfx_wave
;   sfx_change

game_sfx_touched:
    !byte $10, $00, $20, vera_psg_waveform_noise|$3F, -125

game_sfx_gameover:
    !byte $28, $00, $20, vera_psg_waveform_noise|$3F, -64

game_sfx_pause:
    !byte $08, $00, $10, vera_psg_waveform_triangle|$3F, 0

game_sfx_panic:
    !byte $20, $00, $00, vera_psg_waveform_pulse|$3F, 125

game_sfx_panic2:
    !byte $20, $00, $06, vera_psg_waveform_noise|$3F, 0