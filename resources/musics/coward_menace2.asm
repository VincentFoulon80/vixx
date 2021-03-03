!ifndef is_main !eof

; "Coward Menace"
; Original song by Vincent Foulon

m_cowardmenace2:
    !byte N_RTM, 15
    !byte N_INS, 0, I_TINY_LOW_NOISE
    !byte N_INS, 1, I_LONG_SAW
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 2
m_cowardmenace2_1:
    !byte N_VOI, 2
    !byte N_D4, N_D2
    !byte N_D4, N_STP
    !byte N_NOP,N_F2
    !byte N_NOP,N_STP
    !byte N_D4, N_C2
    !byte N_D4, N_STP
    !byte N_NOP,N_E2
    !byte N_NOP,N_STP
m_cowardmenace2_2:
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 3
    !byte N_JMS, <m_cowardmenace2_b3, >m_cowardmenace2_b3

m_cowardmenace2_3:
    !byte N_JMS, <m_cowardmenace2_b4, >m_cowardmenace2_b4

m_cowardmenace2_4:
    !byte N_JMS, <m_cowardmenace2_b3, >m_cowardmenace2_b3

m_cowardmenace2_5:
    !byte N_JMS, <m_cowardmenace2_b5, >m_cowardmenace2_b5


m_cowardmenace2_6:
    !byte N_INS, 2, I_LONG_SAW
    !byte N_JMS, <m_cowardmenace2_b3, >m_cowardmenace2_b3

m_cowardmenace2_7:
    !byte N_JMS, <m_cowardmenace2_b4, >m_cowardmenace2_b4

m_cowardmenace2_8:
    !byte N_JMS, <m_cowardmenace2_b3, >m_cowardmenace2_b3

m_cowardmenace2_9:
    !byte N_JMS, <m_cowardmenace2_b5, >m_cowardmenace2_b5

m_cowardmenace2_10:
    !byte N_INS, 0, I_LONG_TRIANGLE
    !byte N_INS, 1, I_TINY_LOW_NOISE
    !byte N_VOI, 2
    !byte N_JMS, <m_cowardmenace2_b9, >m_cowardmenace2_b9

m_cowardmenace2_11:
    !byte N_F4, N_D4
    !byte N_NOP,N_D4
    !byte N_GNP
    !byte N_G4, N_NOP
    !byte N_NOP,N_D4
    !byte N_NOP,N_D4
    !byte N_F4, N_NOP
    !byte N_E4, N_NOP

m_cowardmenace2_12:
    !byte N_JMS, <m_cowardmenace2_b9, >m_cowardmenace2_b9
    !byte N_D4, N_D4
    !byte N_GNP
    !byte N_GNP
    !byte N_GNP

m_cowardmenace2_end:
    !byte N_JMP, <music_idle, >music_idle


m_cowardmenace2_b3:
    !byte N_D4, N_D2, N_D4
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_F2, N_NOP
    !byte N_NOP,N_STP,N_E4
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_E2, N_C4
    !byte N_NOP,N_STP,N_D4
    !byte N_RTS

m_cowardmenace2_b4:
    !byte N_D4, N_D2, N_F4
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_F2, N_NOP
    !byte N_NOP,N_STP,N_G4
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_E2, N_F4
    !byte N_NOP,N_STP,N_E4
    !byte N_RTS

m_cowardmenace2_b5:
    !byte N_D4, N_D2, N_D4
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_F2, N_STP
    !byte N_NOP,N_STP,N_NOP
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_STP,N_NOP
    !byte N_NOP,N_E2, N_NOP
    !byte N_NOP,N_STP,N_NOP
    !byte N_RTS

m_cowardmenace2_b9:
    !byte N_D4, N_D4
    !byte N_NOP,N_D4
    !byte N_GNP
    !byte N_E4, N_NOP
    !byte N_NOP,N_D4
    !byte N_NOP,N_D4
    !byte N_C4, N_NOP
    !byte N_D4, N_NOP
    !byte N_RTS