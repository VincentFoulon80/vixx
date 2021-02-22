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
!byte CHOR_OP_SBG, t_trace_id
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

!byte CHOR_OP_LDA, $05
!byte CHOR_OP_SPS, $08, $10
.lvl2_s1:
!byte CHOR_OP_LDB, $08
!byte CHOR_OP_MPS, $20, $00
.lvl2_s1_lp:
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_MPS, $00, $08
!byte CHOR_OP_DEB
!byte CHOR_OP_JBN, <.lvl2_s1_lp, >.lvl2_s1_lp
!byte CHOR_OP_DEA
!byte CHOR_OP_MPS, $00, $C0
!byte CHOR_OP_JAN, <.lvl2_s1, >.lvl2_s1


!byte CHOR_OP_SLP, $3C
!pet CHOR_OP_PRD, 2,4, "         ", PET_NULL
!pet CHOR_OP_PRD, 15,5,"          ", PET_NULL
!byte CHOR_OP_SLP, $3C

!pet CHOR_OP_PRD, 4,4, "-end of game-"

.lvl2_s2:
!byte CHOR_OP_SPS, $00, $01
!byte CHOR_OP_SRX
!byte CHOR_OP_INS, id_mov_incr, $03
!byte CHOR_OP_SLP, $18
!byte CHOR_OP_JMP, <.lvl2_s2, >.lvl2_s2