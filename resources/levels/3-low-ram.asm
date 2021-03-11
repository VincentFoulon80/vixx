!ifndef is_main !eof

.lvl3_start:
!byte CHOR_OP_MUS, <m_movingbytes, >m_movingbytes
!byte CHOR_OP_SPR, $02, $7D, bullet_spid
!byte CHOR_OP_SPS, $00, $FF
!byte CHOR_OP_INS, id_mov_incr, $00
!pet CHOR_OP_CHR, 4, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 5, 4, "e"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 6, 4, "v"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 7, 4, "e"
!byte CHOR_OP_SBG, t_empty_id
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 8, 4, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 10, 4, "3"
!pet CHOR_OP_SLP, $10
!byte CHOR_OP_SBG, t_dots_id
!pet CHOR_OP_CHR, 18, 5, "l"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 19, 5, "o"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 20, 5, "w"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 21, 5, " "
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 22, 5, "r"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 23, 5, "a"
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

!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $74

!byte CHOR_OP_SPS, $6F, $01

;
; rain of static obj
;
!byte CHOR_OP_LDB, $0E
.lvl3_s1:
!byte CHOR_OP_LDA, $10
.lvl3_s1_1:
!byte CHOR_OP_INS, id_mov_dlay, $F0
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_JNH, <.lvl3_s1_hd_end, >.lvl3_s1_hd_end   ; \
!byte CHOR_OP_JRN, <.lvl3_s1_hd_r, >.lvl3_s1_hd_r       ;  |- hard mode
!byte CHOR_OP_MPS, $FE, $00                             ;  |)- x-2
!byte CHOR_OP_JMP, <.lvl3_s1_hd_end, >.lvl3_s1_hd_end   ;  |
.lvl3_s1_hd_r:                                          ;  |
!byte CHOR_OP_FPS, $20                                  ;  |)- x+2
.lvl3_s1_hd_end:                                        ; /
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s1_1, >.lvl3_s1_1
!byte CHOR_OP_DEB
!byte CHOR_OP_JEM, <.lvl3_s1_ez, >.lvl3_s1_ez   ; \
!byte CHOR_OP_MPS, $00, $08                     ;  |- NOT easy mode
.lvl3_s1_ez:                                    ; /
!byte CHOR_OP_MPS, $00, $10
!byte CHOR_OP_JRN, <.lvl3_s1_r, >.lvl3_s1_r
!byte CHOR_OP_SRX
!byte CHOR_OP_JMP, <.lvl3_s1_r_end, >.lvl3_s1_r_end
.lvl3_s1_r:
!byte CHOR_OP_SKX, $00
.lvl3_s1_r_end:
!byte CHOR_OP_JBN, <.lvl3_s1, >.lvl3_s1
; clear objs
!byte CHOR_OP_CMO, $02, $20, id_mov_reset, $00
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $22, $20, id_mov_reset, $00
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $42, $3C, id_mov_reset, $00
!byte CHOR_OP_SLP, $20

;
; left wall
;

!byte CHOR_OP_SPS, $08, $01
!byte CHOR_OP_LDA, $08
.lvl3_s2:
!byte CHOR_OP_INS, id_mov_dlay, $F0
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s2, >.lvl3_s2
!byte CHOR_OP_SLP, $3C

!byte CHOR_OP_CMO, $02, $08, id_mov_incr, $31

;
; right wall
;
!byte CHOR_OP_SPS, $D8, $01
!byte CHOR_OP_LDA, $08
.lvl3_s3:
!byte CHOR_OP_INS, id_mov_dlay, $F0
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_SLP, $04
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s3, >.lvl3_s3
!byte CHOR_OP_SLP, $3C

!byte CHOR_OP_CMO, $02+$08, $08, id_mov_dcic, $31

!byte CHOR_OP_SLP, $70

;
; both walls
;

!byte CHOR_OP_LDB, $02
.lvl3_s4
!byte CHOR_OP_SLP, $30
!byte CHOR_OP_CMO, $02, $10, id_mov_reset, $00
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_SPS, $08, $01
!byte CHOR_OP_LDA, $08
.lvl3_s4_1:
!byte CHOR_OP_INS, id_mov_dlay, $F0
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s4_1, >.lvl3_s4_1
!byte CHOR_OP_SPS, $D8, $10
!byte CHOR_OP_LDA, $08
.lvl3_s4_2:
!byte CHOR_OP_INS, id_mov_dlay, $F0
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s4_2, >.lvl3_s4_2
!byte CHOR_OP_SLP, $60

!byte CHOR_OP_CMO, $02, $08, id_mov_incr, $50
!byte CHOR_OP_CMO, $02+$08, $08, id_mov_dcic, $50
!byte CHOR_OP_SLP, $48
!byte CHOR_OP_JNH, <.lvl3_s4_md, >.lvl3_s4_md       ; \
!byte CHOR_OP_CMO, $02, $08, id_mov_dcic, $70       ;  |- hard mode
!byte CHOR_OP_CMO, $02+$08, $08, id_mov_incr, $70   ;  |
.lvl3_s4_md:                                        ; /
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl3_s4, >.lvl3_s4
!byte CHOR_OP_CMO, $02, $08, id_mov_dcic, $50
!byte CHOR_OP_CMO, $02+$08, $08, id_mov_incr, $50

!byte CHOR_OP_SLP, $D0

;
; first rain but sliding right and left
;
!byte CHOR_OP_CMO, $02, $20, id_mov_reset, $00
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_LDB, $06
!byte CHOR_OP_SPS, $6F, $01
.lvl3_s5:
!byte CHOR_OP_LDA, $10
.lvl3_s5_1:
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_JNH, <.lvl3_s5_hd_end, >.lvl3_s5_hd_end   ; \
!byte CHOR_OP_JRN, <.lvl3_s5_hd_r, >.lvl3_s5_hd_r       ;  |- hard mode
!byte CHOR_OP_MPS, $FE, $00                             ;  |)- x-2
!byte CHOR_OP_JMP, <.lvl3_s5_hd_end, >.lvl3_s5_hd_end   ;  |
.lvl3_s5_hd_r:                                          ;  |
!byte CHOR_OP_FPS, $20                                  ;  |)- x+2
.lvl3_s5_hd_end:                                        ; /
!byte CHOR_OP_SLP, $02
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s5_1, >.lvl3_s5_1
!byte CHOR_OP_DEB
!byte CHOR_OP_JEM, <.lvl3_s5_ez, >.lvl3_s5_ez           ; \
!byte CHOR_OP_MPS, $00, $08                             ;  |- NOT easy mode
.lvl3_s5_ez:                                            ; /
!byte CHOR_OP_MPS, $2A, $10
!byte CHOR_OP_JBN, <.lvl3_s5, >.lvl3_s5

.lvl3_s5_p1:
!byte CHOR_OP_SLP, $18
!byte CHOR_OP_JRN, <.lvl3_s5_p1_r, >.lvl3_s5_p1_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icWr, $10
!byte CHOR_OP_JMP, <.lvl3_s5_p2, >.lvl3_s5_p2
.lvl3_s5_p1_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_dcWr, $10
.lvl3_s5_p2:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $60, id_mov_incr, $00
.lvl3_s5_p3:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JRN, <.lvl3_s5_p3_r, >.lvl3_s5_p3_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icWr, $20
!byte CHOR_OP_JMP, <.lvl3_s5_p4, >.lvl3_s5_p4
.lvl3_s5_p3_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_dcWr, $20
.lvl3_s5_p4:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JRN, <.lvl3_s5_p4_r, >.lvl3_s5_p4_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icdc, $21
!byte CHOR_OP_JMP, <.lvl3_s5_p5, >.lvl3_s5_p5
.lvl3_s5_p4_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_decr, $21
.lvl3_s5_p5:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $60, id_mov_incr, $06
.lvl3_s5_p6:
!byte CHOR_OP_SLP, $48

;
; first rain with another pattern
;

!byte CHOR_OP_CMO, $02, $20, id_mov_reset, $00
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_LDB, $06
!byte CHOR_OP_SPS, $6F, $01
.lvl3_s6:
!byte CHOR_OP_LDA, $10
.lvl3_s6_1:
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_FPS, $0F
!byte CHOR_OP_JNH, <.lvl3_s6_hd_end, >.lvl3_s6_hd_end   ; \
!byte CHOR_OP_JRN, <.lvl3_s6_hd_r, >.lvl3_s6_hd_r       ;  |- hard mode
!byte CHOR_OP_MPS, $FE, $00                             ;  |)- x-2
!byte CHOR_OP_JMP, <.lvl3_s6_hd_end, >.lvl3_s6_hd_end   ;  |
.lvl3_s6_hd_r:                                          ;  |
!byte CHOR_OP_FPS, $20                                  ;  |)- x+2
.lvl3_s6_hd_end:                                        ; /
!byte CHOR_OP_SLP, $02
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s6_1, >.lvl3_s6_1
!byte CHOR_OP_DEB
!byte CHOR_OP_JEM, <.lvl3_s6_ez, >.lvl3_s6_ez
!byte CHOR_OP_MPS, $00, $08
.lvl3_s6_ez:
!byte CHOR_OP_MPS, $00, $10
!byte CHOR_OP_SRX, $00, $10
!byte CHOR_OP_JBN, <.lvl3_s6, >.lvl3_s6

.lvl3_s6_p1:
!byte CHOR_OP_SLP, $18
!byte CHOR_OP_JRN, <.lvl3_s6_p1_r, >.lvl3_s6_p1_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icWr, $10
!byte CHOR_OP_JMP, <.lvl3_s6_p2, >.lvl3_s6_p2
.lvl3_s6_p1_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_dcWr, $10
.lvl3_s6_p2:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JRN, <.lvl3_s6_p2_r, >.lvl3_s6_p2_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icWr, $11
!byte CHOR_OP_JMP, <.lvl3_s6_p3, >.lvl3_s6_p3
.lvl3_s6_p2_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_dcWr, $11
.lvl3_s6_p3:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JRN, <.lvl3_s6_p3_r, >.lvl3_s6_p3_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icWr, $20
!byte CHOR_OP_JMP, <.lvl3_s6_p4, >.lvl3_s6_p4
.lvl3_s6_p3_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_dcWr, $20
.lvl3_s6_p4:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_JRN, <.lvl3_s6_p4_r, >.lvl3_s6_p4_r
!byte CHOR_OP_CMO, $02, $60, id_mov_icdc, $21
!byte CHOR_OP_JMP, <.lvl3_s6_p5, >.lvl3_s6_p5
.lvl3_s6_p4_r:
!byte CHOR_OP_CMO, $02, $60, id_mov_decr, $21
.lvl3_s6_p5:
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $60, id_mov_incr, $06
.lvl3_s6_p6:
!byte CHOR_OP_SLP, $48

;
; constant rain with changing movements
;

!byte CHOR_OP_SPS, $6F, $01
!byte CHOR_OP_LDC, $03
!byte CHOR_OP_JNH, <.lvl3_s7_md, >.lvl3_s7_md   ; \
    !byte CHOR_OP_LDC, $05                      ;  |- hard mode
.lvl3_s7_md:                                    ; /
!byte CHOR_OP_JNE, <.lvl3_s7_ez, >.lvl3_s7_ez   ; \
    !byte CHOR_OP_LDC, $08                      ;  |- easy mode
.lvl3_s7_ez:                                    ; /
!byte CHOR_OP_LDB, $36
.lvl3_s7:
!byte CHOR_OP_LDA, $05
.lvl3_s7_1:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_icWr, $02
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s7_1, >.lvl3_s7_1
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEC
!byte CHOR_OP_JCZ, <.lvl3_s7_c, >.lvl3_s7_c
.lvl3_s7_ce:
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl3_s7, >.lvl3_s7
!byte CHOR_OP_JMP, <.lvl3_s7_end, >.lvl3_s7_end

    .lvl3_s7_c:
    !byte CHOR_OP_LDC, $03
    !byte CHOR_OP_JNH, <.lvl3_s7_c_md, >.lvl3_s7_c_md   ; \
        !byte CHOR_OP_LDC, $05                          ;  |- hard mode
    .lvl3_s7_c_md:                                      ; /
    !byte CHOR_OP_JNE, <.lvl3_s7_c_ez, >.lvl3_s7_c_ez   ; \
        !byte CHOR_OP_LDC, $08                          ;  |- easy mode
    .lvl3_s7_c_ez:                                      ; /
    !byte CHOR_OP_JRN, <.lvl3_s7_r2, >.lvl3_s7_r2
    ; rand 1
    !byte CHOR_OP_CMO, $02, $7D, id_mov_icWr, $12
    !byte CHOR_OP_JNH, <.lvl3_s7_ce, >.lvl3_s7_ce       ; \_ hard mode
        !byte CHOR_OP_CMO, $02, $7D, id_mov_icWr, $22   ; /
    !byte CHOR_OP_JMP, <.lvl3_s7_ce, >.lvl3_s7_ce
    .lvl3_s7_r2:
    ; rand 2
    !byte CHOR_OP_CMO, $02, $7D, id_mov_dcWr, $12
    !byte CHOR_OP_JNH, <.lvl3_s7_ce, >.lvl3_s7_ce       ; \_ hard mode
        !byte CHOR_OP_CMO, $02, $7D, id_mov_dcWr, $22   ; /
    !byte CHOR_OP_JMP, <.lvl3_s7_ce, >.lvl3_s7_ce
    .lvl3_s7_end:

!byte CHOR_OP_CMO, $02, $7D, id_mov_icWr, $12
!byte CHOR_OP_JNH, <.lvl3_s7_md_end, >.lvl3_s7_md_end   ; \_ hard mode
    !byte CHOR_OP_CMO, $02, $7D, id_mov_icWr, $22       ; /
.lvl3_s7_md_end:
!byte CHOR_OP_SLP, $F0
!byte CHOR_OP_CMO, $02, $7D, id_mov_reset, $00
!byte CHOR_OP_SLP, $01

;
; set up bullets with this pattern
;  |<- <- <- <-
;  V
;  -> -> -> ->|
;             V
;   <- <- <- <-

!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SPS, $D8, $10
.lvl3_s8:
!byte CHOR_OP_LDA, $08
.lvl3_s8_1:
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_MPS, $E2, $00
!byte CHOR_OP_SLP, $02
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s8_1, >.lvl3_s8_1
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_MPS, $00, $1E
!byte CHOR_OP_LDA, $08
.lvl3_s8_2:
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_MPS, $1E, $00
!byte CHOR_OP_SLP, $02
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s8_2, >.lvl3_s8_2
!byte CHOR_OP_INS, id_mov_incr, $00
!byte CHOR_OP_MPS, $00, $1E

!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl3_s8, >.lvl3_s8

;
; move the bullet grid
;

!byte CHOR_OP_SLP, $18
!byte CHOR_OP_LDA, $48
.lvl3_s8_3:
!byte CHOR_OP_COA, $01, id_mov_decr, $01
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s8_3, >.lvl3_s8_3

!byte CHOR_OP_LDA, $48
.lvl3_s8_4:
!byte CHOR_OP_COA, $01, id_mov_incr, $10
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s8_4, >.lvl3_s8_4

!byte CHOR_OP_LDA, $48
.lvl3_s8_5:
!byte CHOR_OP_COA, $01, id_mov_dcic, $11
!byte CHOR_OP_SLP, $01
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s8_5, >.lvl3_s8_5

;
; move faster
;

.lvl3_s8_6:
!byte CHOR_OP_CMO, $02, $48, id_mov_decr, $02
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $48, id_mov_incr, $20
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $48, id_mov_dcic, $22
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_CMO, $02, $48, id_mov_incr, $04
!byte CHOR_OP_SLP, $C0

;
; throw walls of bullets directly at the player
;

!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_LDB, $08
.lvl3_s9:
!byte CHOR_OP_LDA, $08
!byte CHOR_OP_SKX, $00
!byte CHOR_OP_MPS, $E8, $00
.lvl3_s9_1:
!byte CHOR_OP_JNH, <.lvl3_s9_md, >.lvl3_s9_md
!byte CHOR_OP_INS, id_mov_incr, $06
!byte CHOR_OP_JMP, <.lvl3_s9_hd, >.lvl3_s9_hd
.lvl3_s9_md:
!byte CHOR_OP_INS, id_mov_incr, $05
.lvl3_s9_hd:
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_s9_1, >.lvl3_s9_1
!byte CHOR_OP_SLP, $30
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl3_s9, >.lvl3_s9



.lvl3_boss1:
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_MOJ, $01, $6D, $00
!byte CHOR_OP_COJ, $01, id_mov_incr, $01
!byte CHOR_OP_MUS, <m_cowardmenace3, >m_cowardmenace3
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_COJ, $01, id_mov_incr, $00
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning


!byte CHOR_OP_LDB, $04
.lvl3_boss1_main:
!byte CHOR_OP_SPS, $01, $01
!byte CHOR_OP_LDA, $09
.lvl3_boss1_lp1:
!byte CHOR_OP_INS, id_mov_incr, $04
!byte CHOR_OP_MPS, $1E, $00
!byte CHOR_OP_SLP, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_boss1_lp1, >.lvl3_boss1_lp1
!byte CHOR_OP_JEM, <.lvl3_boss1_lp1_ez, >.lvl3_boss1_lp1_ez ; \
!byte CHOR_OP_SKX, $00                                      ;  | NOT easy
!byte CHOR_OP_INS, id_mov_incr, $04                         ;  |
.lvl3_boss1_lp1_ez:                                         ; /

!byte CHOR_OP_SPS, $E8, $01
!byte CHOR_OP_LDA, $09
.lvl3_boss1_lp2:
!byte CHOR_OP_INS, id_mov_decr, $40
!byte CHOR_OP_MPS, $00, $1E
!byte CHOR_OP_SLP, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_boss1_lp2, >.lvl3_boss1_lp2
!byte CHOR_OP_JEM, <.lvl3_boss1_lp2_ez, >.lvl3_boss1_lp2_ez ; \
!byte CHOR_OP_SKY, $00                                      ;  | NOT easy
!byte CHOR_OP_INS, id_mov_decr, $40                         ;  |
.lvl3_boss1_lp2_ez:                                         ; /

!byte CHOR_OP_JNH, <.lvl3_boss1_md, >.lvl3_boss1_md ; \
!byte CHOR_OP_SEK, $01                              ;  |
!byte CHOR_OP_BIS, 6                                ;  | HARD MODE ONLY
    !byte id_mov_dcic, $40                          ;  |          
    !byte id_mov_dcic, $31                          ;  |
    !byte id_mov_dcic, $22                          ;  |
    !byte id_mov_dcic, $13                          ;  |
    !byte id_mov_dcic, $04                          ;  |
    !byte id_mov_incr, $13                          ;  |
!byte CHOR_OP_BIS, 6                                ;  |
    !byte id_mov_incr, $22                          ;  |
    !byte id_mov_incr, $31                          ;  |
    !byte id_mov_incr, $40                          ;  |
    !byte id_mov_decr, $40                          ;  |
    !byte id_mov_decr, $31                          ;  |
    !byte id_mov_decr, $22                          ;  |
!byte CHOR_OP_BIS, 6                                ;  |
    !byte id_mov_decr, $13                          ;  |
    !byte id_mov_decr, $04                          ;  |
    !byte id_mov_icdc, $13                          ;  |
    !byte id_mov_icdc, $22                          ;  |
    !byte id_mov_icdc, $31                          ;  |
    !byte id_mov_icdc, $40                          ;  |
.lvl3_boss1_md:                                     ; /

!byte CHOR_OP_SPS, $E8, $E8
!byte CHOR_OP_LDA, $09
.lvl3_boss1_lp3:
!byte CHOR_OP_INS, id_mov_decr, $04
!byte CHOR_OP_MPS, $E2, $00
!byte CHOR_OP_SLP, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_boss1_lp3, >.lvl3_boss1_lp3
!byte CHOR_OP_JEM, <.lvl3_boss1_lp3_ez, >.lvl3_boss1_lp3_ez ; \
!byte CHOR_OP_SKX, $00                                      ;  | NOT easy
!byte CHOR_OP_INS, id_mov_decr, $04                         ;  |
.lvl3_boss1_lp3_ez:                                         ; /

!byte CHOR_OP_SPS, $01, $E8
!byte CHOR_OP_LDA, $09
.lvl3_boss1_lp4:
!byte CHOR_OP_INS, id_mov_incr, $40
!byte CHOR_OP_MPS, $00, $E2
!byte CHOR_OP_SLP, $07
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl3_boss1_lp4, >.lvl3_boss1_lp4
!byte CHOR_OP_JEM, <.lvl3_boss1_lp4_ez, >.lvl3_boss1_lp4_ez ; \
!byte CHOR_OP_SKY, $00                                      ;  | NOT easy
!byte CHOR_OP_INS, id_mov_incr, $40                         ;  |
.lvl3_boss1_lp4_ez:                                         ; /

!byte CHOR_OP_JNH, <.lvl3_boss1_md2, >.lvl3_boss1_md2;\
!byte CHOR_OP_SEK, $01                              ;  |
!byte CHOR_OP_BIS, 6                                ;  | HARD MODE ONLY
    !byte id_mov_dcic, $40                          ;  |          
    !byte id_mov_dcic, $31                          ;  |
    !byte id_mov_dcic, $22                          ;  |
    !byte id_mov_dcic, $13                          ;  |
    !byte id_mov_dcic, $04                          ;  |
    !byte id_mov_incr, $13                          ;  |
!byte CHOR_OP_BIS, 6                                ;  |
    !byte id_mov_incr, $22                          ;  |
    !byte id_mov_incr, $31                          ;  |
    !byte id_mov_incr, $40                          ;  |
    !byte id_mov_decr, $40                          ;  |
    !byte id_mov_decr, $31                          ;  |
    !byte id_mov_decr, $22                          ;  |
!byte CHOR_OP_BIS, 6                                ;  |
    !byte id_mov_decr, $13                          ;  |
    !byte id_mov_decr, $04                          ;  |
    !byte id_mov_icdc, $13                          ;  |
    !byte id_mov_icdc, $22                          ;  |
    !byte id_mov_icdc, $31                          ;  |
    !byte id_mov_icdc, $40                          ;  |
.lvl3_boss1_md2:                                    ; /

!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl3_boss1_main, >.lvl3_boss1_main

.lvl3_boss1_2:
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
!byte CHOR_OP_SLP, $20
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

.lvl3_boss1_end:
!byte CHOR_OP_SOT, $00
!byte CHOR_OP_COJ, $01, id_mov_incr, $02
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COJ, $01, id_mov_rng, $00
!byte CHOR_OP_SLP, $90
!byte CHOR_OP_SPR, $01, $01, virus4_spid
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_COJ, $01, id_mov_incr, $00
!byte CHOR_OP_SLP, $3C
!byte CHOR_OP_COJ, $01, id_mov_decr, $02
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4,"level cleared!", PET_NULL
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,5,"bonus: 1000 pts", PET_NULL
!byte CHOR_OP_SLP, $18
!pet CHOR_OP_PRD, 2,6,"     +2 lives!", PET_NULL
!byte CHOR_OP_LIF
!byte CHOR_OP_LIF
!byte CHOR_OP_SCO, $00, $10, $00
!byte CHOR_OP_SLP, $72
!pet CHOR_OP_PRD, 2,7,"remaining: 40%", PET_NULL
!byte CHOR_OP_SLP, $72

!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,5, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,6, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,7, <lvl1_str_clr_ending, >lvl1_str_clr_ending