!ifndef is_main !eof

.lvl1_start:
; insert player
!byte CHOR_OP_MUS, <m_seeking, >m_seeking
!byte CHOR_OP_SBG, t_square_id
!pet CHOR_OP_CHR, 4, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 5, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 6, 4, "v"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 7, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 8, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 10, 4, "1"
!pet CHOR_OP_SLP, $10
!pet CHOR_OP_CHR, 15, 5, "f"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 16, 5, "i"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 17, 5, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 18, 5, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 19, 5, "s"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 20, 5, "y"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 21, 5, "s"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 22, 5, "t"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 23, 5, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 24, 5, "m"
!byte CHOR_OP_SOT, $01
!byte CHOR_OP_SCR, $03
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $02
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $01
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $04
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SLP, $3C

;
; initial throw
;

.lvl1_s1:
!byte CHOR_OP_LDA, $06
!byte CHOR_OP_SPS, $18, $01
.lvl1_s1_lp:
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_DEA
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JAN, <.lvl1_s1_lp, >.lvl1_s1_lp

!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $78

;
; spawn bullets making a static diagonal
;

.lvl1_s2:
!byte CHOR_OP_SPS, $20, $20
!byte CHOR_OP_LDA, $0B

.lvl1_s2_lp:
!byte CHOR_OP_BIS, 3
    !byte id_mov_incr, $02
    !byte id_mov_incr, $12
    !byte id_mov_dcic, $12
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.lvl1_s2_lp, >.lvl1_s2_lp

;
; cut the screen with diagonals
;

.lvl1_s3:
!byte CHOR_OP_SPS, $02, $02
!byte CHOR_OP_LDA, $18

.lvl1_s3_lp:
!byte CHOR_OP_BIS, 2
    !byte id_mov_incr, $12
    !byte id_mov_incr, $22
!byte CHOR_OP_JNH, <.lvl1_s3_md, >.lvl1_s3_md
!byte CHOR_OP_SPS, $E6, $02
!byte CHOR_OP_BIS, 2
    !byte id_mov_dcic, $12
    !byte id_mov_dcic, $22
!byte CHOR_OP_SPS, $02, $02
.lvl1_s3_md:
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JAN, <.lvl1_s3_lp, >.lvl1_s3_lp

;
; "explosions" in the center
;

.lvl1_s4:
!byte CHOR_OP_SPS, $6F, $20
!byte CHOR_OP_LDA, $08
!byte CHOR_OP_JNH, <.lvl1_s4_lp, >.lvl1_s4_lp         ; \_ hard mode: double number of explosions
!byte CHOR_OP_LDA, $10                                ; /

.lvl1_s4_lp:
!byte CHOR_OP_JNH, <.lvl1_s4_exp, >.lvl1_s4_exp         ; \
!byte CHOR_OP_JRN, <.lvl1_s4_h_plus, >.lvl1_s4_h_plus   ;  |- hard mode
; .lvl1_s4_h_minus:                                     ;  |
!byte CHOR_OP_MPS, $F1, $00                             ;  |> x-15
!byte CHOR_OP_JMP, <.lvl1_s4_exp, >.lvl1_s4_exp         ;  |
.lvl1_s4_h_plus:                                        ;  |
!byte CHOR_OP_FPS, $F0                                  ;  |> x+15
                                                        ; /
.lvl1_s4_exp:
!byte CHOR_OP_BIS, 6
    !byte id_mov_dcic, $40
    !byte id_mov_dcic, $31
    !byte id_mov_dcic, $22
    !byte id_mov_dcic, $13
    !byte id_mov_dcic, $04
    !byte id_mov_incr, $13
!byte CHOR_OP_BIS, 6
    !byte id_mov_incr, $22
    !byte id_mov_incr, $31
    !byte id_mov_incr, $40
    !byte id_mov_decr, $40
    !byte id_mov_decr, $31
    !byte id_mov_decr, $22
!byte CHOR_OP_BIS, 6
    !byte id_mov_decr, $13
    !byte id_mov_decr, $04
    !byte id_mov_icdc, $13
    !byte id_mov_icdc, $22
    !byte id_mov_icdc, $31
    !byte id_mov_icdc, $40
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JHM, <.lvl1_s4_endlp, >.lvl1_s4_endlp ; \
!byte CHOR_OP_SLP, $10                              ;  |- hard mode: sleep half time
.lvl1_s4_endlp:                                     ; /
!byte CHOR_OP_JAN, <.lvl1_s4_lp, >.lvl1_s4_lp
!byte CHOR_OP_SLP, $30

!byte CHOR_OP_LDA, $08
.lvl1_s4_blk:
!pet CHOR_OP_PRD, 2,4, "virus located", PET_NULL
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRD, 2,4, "             ", PET_NULL
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl1_s4_blk, >.lvl1_s4_blk
!byte CHOR_OP_SCR, $07

;
; flying, slow
;

.lvl1_s5:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_LDA, $20
!byte CHOR_OP_JNH, <.lvl1_s5_lp, >.lvl1_s5_lp         ; \_ hard mode: double number of explosions
!byte CHOR_OP_LDA, $40                                ; /

.lvl1_s5_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $04
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_JHM, <.lvl1_s5_endlp, >.lvl1_s5_endlp ; \
!byte CHOR_OP_SLP, $08                              ;  |- hard mode: sleep half time
.lvl1_s5_endlp:                                     ; /
!byte CHOR_OP_JAN, <.lvl1_s5_lp, >.lvl1_s5_lp

!byte CHOR_OP_SCR, $06
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_SCR, $05
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_CMO, $02, $7D, id_mov_incr, $05
!byte CHOR_OP_SCR, $08

;
; flying, faster
;

.lvl1_s6:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_LDA, $20

.lvl1_s6_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_JAN, <.lvl1_s6_lp, >.lvl1_s6_lp

!byte CHOR_OP_SCR, $0B
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_SCR, $0A
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_SCR, $09
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_CMO, $02, $7D, id_mov_incr, $07
!byte CHOR_OP_SCR, $0C

;
; flying, fastest
;

.lvl1_s7:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_LDA, $20
!byte CHOR_OP_JNH, <.lvl1_s7_lp, >.lvl1_s7_lp         ; \_ hard mode: double number of explosions
!byte CHOR_OP_LDA, $40                                ; /

.lvl1_s7_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_JHM, <.lvl1_s7_endlp, >.lvl1_s7_endlp ; \
!byte CHOR_OP_SLP, $04                              ;  |- hard mode: sleep half time
.lvl1_s7_endlp:                                     ; /
!byte CHOR_OP_JAN, <.lvl1_s7_lp, >.lvl1_s7_lp

!byte CHOR_OP_SCR, $0F
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_SCR, $0E
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_SCR, $0D
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_CMO, $02, $7D, id_mov_incr, $0B
!byte CHOR_OP_SCR, $10

;
; flying, max speed
;

.lvl1_s8:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_LDA, $30

.lvl1_s8_lp:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $0B
!byte CHOR_OP_DEA
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_JAN, <.lvl1_s8_lp, >.lvl1_s8_lp
!byte CHOR_OP_SLP, $7C

;
; boss
;

.lvl1_boss1:
!pet CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SCR, $0D
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0E
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $0F
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $08
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SCR, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $06
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $07
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $04
!byte CHOR_OP_SLP, $10
!pet CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SCR, $01
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $02
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $03
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $00
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_MOJ, $01, $6D, $00
!byte CHOR_OP_COJ, $01, id_mov_incr, $01
!byte CHOR_OP_MUS, <m_cowardmenace, >m_cowardmenace
!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_COJ, $01, id_mov_incr, $00
!pet CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning

!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COJ, $01, id_mov_bcir, $00
!byte CHOR_OP_SLP, $3C
!byte CHOR_OP_LDA, $02
!byte CHOR_OP_LDC, $0D
.lvl1_boss1_lp:
!byte CHOR_OP_SPR, $02, $7D, bullet_glitch1_spid
!byte CHOR_OP_SPS, $08, $10
!byte CHOR_OP_BIS, 3
    !byte id_mov_incr, $22
    !byte id_mov_incr, $31
    !byte id_mov_incr, $13
!byte CHOR_OP_SPS, $D9, $10
!byte CHOR_OP_BIS, 3
    !byte id_mov_dcic, $22
    !byte id_mov_dcic, $31
    !byte id_mov_dcic, $13
!byte CHOR_OP_SPS, $08, $60
!byte CHOR_OP_BIS, 2
    !byte id_mov_incr, $22
    !byte id_mov_icdc, $22
!byte CHOR_OP_SPS, $D9, $60
!byte CHOR_OP_BIS, 2
    !byte id_mov_dcic, $22
    !byte id_mov_decr, $22
!byte CHOR_OP_SPS, $08, $D0
!byte CHOR_OP_BIS, 3
    !byte id_mov_icdc, $22
    !byte id_mov_icdc, $31
    !byte id_mov_icdc, $13
!byte CHOR_OP_SPS, $D9, $D0
!byte CHOR_OP_BIS, 3
    !byte id_mov_decr, $22
    !byte id_mov_decr, $31
    !byte id_mov_decr, $13
!byte CHOR_OP_JNH, <.lvl1_boss1_skip_exp, >.lvl1_boss1_skip_exp
!byte CHOR_OP_SEK, $01
!byte CHOR_OP_BIS, 6
    !byte id_mov_dcic, $40
    !byte id_mov_dcic, $31
    !byte id_mov_dcic, $22
    !byte id_mov_dcic, $13
    !byte id_mov_dcic, $04
    !byte id_mov_incr, $13
!byte CHOR_OP_BIS, 6
    !byte id_mov_incr, $22
    !byte id_mov_incr, $31
    !byte id_mov_incr, $40
    !byte id_mov_decr, $40
    !byte id_mov_decr, $31
    !byte id_mov_decr, $22
!byte CHOR_OP_BIS, 6
    !byte id_mov_decr, $13
    !byte id_mov_decr, $04
    !byte id_mov_icdc, $13
    !byte id_mov_icdc, $22
    !byte id_mov_icdc, $31
    !byte id_mov_icdc, $40
.lvl1_boss1_skip_exp:
!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SPS, $00, $02
.lvl1_boss1_lp2:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_SPR, $02, $7D, bullet_glitch2_spid
!byte CHOR_OP_SRX
!byte CHOR_OP_DEA
!byte CHOR_OP_DEB
!byte CHOR_OP_JAZ, <.lvl1_boss1_diag, >.lvl1_boss1_diag
!byte CHOR_OP_DEC
!byte CHOR_OP_JCZ, <.lvl1_boss1_end, >.lvl1_boss1_end 
!byte CHOR_OP_INS, id_mov_incr, $02
!byte CHOR_OP_JBN, <.lvl1_boss1_lp2, >.lvl1_boss1_lp2
!byte CHOR_OP_JMP, <.lvl1_boss1_lp, >.lvl1_boss1_lp
; ;;
; !byte CHOR_OP_JMP, <.lvl1_s2, >.lvl1_s2
.lvl1_boss1_diag:
!byte CHOR_OP_INS, id_mov_incr, $13
!byte CHOR_OP_INS, id_mov_dcic, $13
!byte CHOR_OP_LDA, $02
!byte CHOR_OP_JBN, <.lvl1_boss1_lp2, >.lvl1_boss1_lp2
!byte CHOR_OP_JMP, <.lvl1_boss1_lp, >.lvl1_boss1_lp

.lvl1_boss1_end:
!byte CHOR_OP_SOT, $00
!byte CHOR_OP_COJ, $01, id_mov_incr, $02
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COJ, $01, id_mov_rng, $00
!byte CHOR_OP_SLP, $90
!byte CHOR_OP_SPR, $01, $01, virus2_spid
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_COJ, $01, id_mov_incr, $00
!byte CHOR_OP_SLP, $3C
!byte CHOR_OP_COJ, $01, id_mov_decr, $02
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4,"level cleared!", PET_NULL
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,5,"bonus: 1000 pts", PET_NULL
!byte CHOR_OP_SLP, $18
!pet CHOR_OP_PRD, 2,6,"       +1 life!", PET_NULL
!byte CHOR_OP_LIF
!byte CHOR_OP_SCO, $00, $10, $00
!byte CHOR_OP_SLP, $72
!pet CHOR_OP_PRD, 2,7,"remaining: 80%", PET_NULL
!byte CHOR_OP_SLP, $72

!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,5, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,6, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,7, <lvl1_str_clr_ending, >lvl1_str_clr_ending
; --- end of lvl1