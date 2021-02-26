!ifndef is_main !eof

.lvl2_start:
; insert player
!byte CHOR_OP_MUS, <m_datarain, >m_datarain
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
!pet CHOR_OP_CHR, 10, 4, "2"
!pet CHOR_OP_SLP, $10
!pet CHOR_OP_CHR, 17, 5, "h"
!pet CHOR_OP_SLP, $08
!byte CHOR_OP_SBG, t_trace_b0_id
!pet CHOR_OP_CHR, 18, 5, "i"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 19, 5, "g"
!pet CHOR_OP_SLP, $08
!pet CHOR_OP_CHR, 20, 5, "h"
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

; !byte CHOR_OP_LDA, $05
; !byte CHOR_OP_SPS, $08, $10
; .lvl2_s1:
; !byte CHOR_OP_LDB, $08
; !byte CHOR_OP_MPS, $20, $00
; .lvl2_s1_lp:
; !byte CHOR_OP_INS, id_mov_incr, $03
; !byte CHOR_OP_MPS, $00, $08
; !byte CHOR_OP_DEB
; !byte CHOR_OP_JBN, <.lvl2_s1_lp, >.lvl2_s1_lp
; !byte CHOR_OP_DEA
; !byte CHOR_OP_MPS, $00, $C0
; !byte CHOR_OP_JAN, <.lvl2_s1, >.lvl2_s1


!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $18

!byte CHOR_OP_LDA, $09
!byte CHOR_OP_SPS, $01,$18
.lvl2_s1:
!byte CHOR_OP_INS, id_mov_incr, $32
!byte CHOR_OP_MPS, $E0,$00
!byte CHOR_OP_INS, id_mov_dcic, $32
!byte CHOR_OP_MPS, $20,$10
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s1, >.lvl2_s1

!byte CHOR_OP_SLP, $18
!byte CHOR_OP_LDA, $04
.lvl2_s2:
!byte CHOR_OP_ISP, $10, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $D0, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $20, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $C0, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $30, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $B0, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $40, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $A0, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $50, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $90, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $60, $01, id_mov_incr, $04
!byte CHOR_OP_ISP, $80, $01, id_mov_incr, $04
!byte CHOR_OP_SLP, $08
!byte CHOR_OP_ISP, $70, $01, id_mov_incr, $04

!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SPS, $01,$20
.lvl2_s2_1:
!byte CHOR_OP_INS, id_mov_incr, $34
!byte CHOR_OP_MPS, $E0, $00
!byte CHOR_OP_INS, id_mov_dcic, $34
!byte CHOR_OP_MPS, $20, $10
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl2_s2_1, >.lvl2_s2_1

!byte CHOR_OP_SLP, $30
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s2, >.lvl2_s2

!byte CHOR_OP_SCR, $07
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_SCR, $06
!byte CHOR_OP_LDA, $07
!byte CHOR_OP_SPS, $08, $01
.lvl2_s3:
!byte CHOR_OP_BIS, $02, id_mov_incr, $14, id_mov_incr, $04
!byte CHOR_OP_MPS, $10, $00
!byte CHOR_OP_ISP, $6F, $00, id_mov_incr, $05
!byte CHOR_OP_ISP, $6F, $08, id_mov_incr, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s3, >.lvl2_s3

!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_LDA, $08
!byte CHOR_OP_SPS, $E8, $01
.lvl2_s4:
!byte CHOR_OP_BIS, $02, id_mov_dcic, $14, id_mov_dcic, $04
!byte CHOR_OP_MPS, $F0, $00
!byte CHOR_OP_ISP, $6F, $00, id_mov_incr, $05
!byte CHOR_OP_ISP, $6F, $08, id_mov_incr, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s4, >.lvl2_s4

!byte CHOR_OP_LDC, $02
!byte CHOR_OP_LDB, $0C
.lvl2_s5:
!byte CHOR_OP_ISP, $6F, $00, id_mov_incr, $05
!byte CHOR_OP_ISP, $6F, $08, id_mov_incr, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_JBZ, <.lvl2_s5_2, >.lvl2_s5_2
!byte CHOR_OP_DEB
!byte CHOR_OP_JMP, <.lvl2_s5, >.lvl2_s5
.lvl2_s5_2:
!byte CHOR_OP_DEC
!byte CHOR_OP_JCZ, <.lvl2_s6, >.lvl2_s6
!byte CHOR_OP_LDB, $0B
!byte CHOR_OP_SPS, $08, $01
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_JMP, <.lvl2_s5, >.lvl2_s5 

.lvl2_s6:
!byte CHOR_OP_SPS, $08, $01
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_FPS, $F0
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_FPS, $80
!byte CHOR_OP_INS, id_mov_incr, $05

!byte CHOR_OP_LDA, $0E
.lvl2_s7:
!byte CHOR_OP_ISP, $6F, $00, id_mov_incr, $05
!byte CHOR_OP_ISP, $6F, $08, id_mov_incr, $05
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s7, >.lvl2_s7

!pet CHOR_OP_PRT, 2,4, <lvl2_str_bank_switched, >lvl2_str_bank_switched
!byte CHOR_OP_SBG, t_trace_b1_id
!byte CHOR_OP_SLP, $50
!pet CHOR_OP_PRT, 2,4, <lvl2_str_clr_bank_switched, >lvl2_str_clr_bank_switched
!byte CHOR_OP_LDA, $10
.lvl2_s8:
!byte CHOR_OP_SPS, $08, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
!byte CHOR_OP_SLP, $06
!byte CHOR_OP_SPS, $E0, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $06
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s8, >.lvl2_s8

!byte CHOR_OP_LDA, $10
!byte CHOR_OP_SPS, $6F, $08
.lvl2_s9:
!byte CHOR_OP_BIS, 9
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
    !byte id_mov_incr, $05
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s9, >.lvl2_s9

!byte CHOR_OP_LDA, $10
.lvl2_s10:
!byte CHOR_OP_SRX
!byte CHOR_OP_BIS, 8
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $16
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s10, >.lvl2_s10

!byte CHOR_OP_SLP, $50
!pet CHOR_OP_PRT, 2,4, <lvl2_str_bank_switched, >lvl2_str_bank_switched
!byte CHOR_OP_SBG, t_trace_b2_id
!byte CHOR_OP_SLP, $50
!pet CHOR_OP_PRT, 2,4, <lvl2_str_clr_bank_switched, >lvl2_str_clr_bank_switched
!byte CHOR_OP_LDA, $08
!byte CHOR_OP_SPS, $6F, $08
.lvl2_s11:
!byte CHOR_OP_BIS, 9
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
    !byte id_mov_incr, $05
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_ISP, $08, $08, id_mov_incr, $25
!byte CHOR_OP_ISP, $E0, $08, id_mov_dcic, $25
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s11, >.lvl2_s11

!byte CHOR_OP_LDA, $08
.lvl2_s12:
!byte CHOR_OP_SPS, $08, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_SPS, $E0, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_ISP, $08, $08, id_mov_incr, $25
!byte CHOR_OP_ISP, $E0, $08, id_mov_dcic, $25
!byte CHOR_OP_SLP, $16
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s12, >.lvl2_s12

!byte CHOR_OP_LDA, $10

.lvl2_s13:
!byte CHOR_OP_SPS, $08, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_SPS, $E0, $08
!byte CHOR_OP_BIS, 4
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $0B
!byte CHOR_OP_SPS, $6F, $08
!byte CHOR_OP_SRX
!byte CHOR_OP_BIS, 9
    !byte id_mov_incr, $14
    !byte id_mov_incr, $23
    !byte id_mov_incr, $33
    !byte id_mov_incr, $42
    !byte id_mov_incr, $05
    !byte id_mov_dcic, $14
    !byte id_mov_dcic, $23
    !byte id_mov_dcic, $33
    !byte id_mov_dcic, $42
!byte CHOR_OP_SLP, $16
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s13, >.lvl2_s13

!byte CHOR_OP_SLP, $50
!pet CHOR_OP_PRT, 2,4, <lvl2_str_bank_switched, >lvl2_str_bank_switched
!byte CHOR_OP_SBG, t_trace_b0_id
!byte CHOR_OP_SLP, $50
!pet CHOR_OP_PRT, 2,4, <lvl2_str_clr_bank_switched, >lvl2_str_clr_bank_switched

!byte CHOR_OP_LDA, $18
!byte CHOR_OP_LDB, $10
!byte CHOR_OP_SPS, $00,$00
.lvl2_s14:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl2_s14, >.lvl2_s14
!byte CHOR_OP_LDB, $08
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s14, >.lvl2_s14

!byte CHOR_OP_LDA, $08
!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SPS, $00,$00
.lvl2_s15:
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $05
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl2_s15, >.lvl2_s15
!byte CHOR_OP_LDB, $04
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_s15, >.lvl2_s15

!byte CHOR_OP_SLP, $20

.lvl2_boss1:
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_MOB, $01, $6D, $00
!byte CHOR_OP_COB, $01, id_mov_incr, $01
!byte CHOR_OP_MUS, <m_cowardmenace, >m_cowardmenace
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_COB, $01, id_mov_incr, $00
!byte CHOR_OP_PRT, 2,4, <lvl1_str_warning, >lvl1_str_warning
!byte CHOR_OP_SLP, $40
!byte CHOR_OP_PRT, 2,4, <lvl1_str_clr_warning, >lvl1_str_clr_warning

!byte CHOR_OP_SBG, t_trace_gl_id
!byte CHOR_OP_COB, $01, id_mov_Iinc, $41
!byte CHOR_OP_LDA, $20
.lvl2_boss1_lp:
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
!byte CHOR_OP_DEA
!byte CHOR_OP_JAN, <.lvl2_boss1_lp, >.lvl2_boss1_lp

.lvl2_boss1_end:
!byte CHOR_OP_SOT, $00
!byte CHOR_OP_COB, $01, id_mov_incr, $02
!byte CHOR_OP_SLP, $20
!byte CHOR_OP_COB, $01, id_mov_rng, $00
!byte CHOR_OP_SLP, $90
!byte CHOR_OP_SPR, $01, $01, virus3_spid
!byte CHOR_OP_SLP, $10
!byte CHOR_OP_COB, $01, id_mov_incr, $00
!byte CHOR_OP_SLP, $3C
!byte CHOR_OP_COB, $01, id_mov_decr, $02
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4,"level cleared!", PET_NULL
!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,5,"bonus: 1000 pts", PET_NULL
!byte CHOR_OP_SLP, $18
!pet CHOR_OP_PRD, 2,6,"     +2 panics!", PET_NULL
!byte CHOR_OP_PNC
!byte CHOR_OP_PNC
!byte CHOR_OP_SCO, $00, $10, $00
!byte CHOR_OP_SLP, $72
!pet CHOR_OP_PRD, 2,7,"remaining: 60%", PET_NULL
!byte CHOR_OP_SLP, $72

!pet CHOR_OP_PRT, 2,4, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,5, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,6, <lvl1_str_clr_ending, >lvl1_str_clr_ending
!pet CHOR_OP_PRT, 2,7, <lvl1_str_clr_ending, >lvl1_str_clr_ending