!ifndef is_main !eof

; "Coward Menace"
; Original song by Vincent Foulon

m_cowardmenace:
    !byte N_RTM, 15
    !byte N_INS, 0, I_TINY_PULSE
    !byte N_INS, 1, I_TINY_LOW_NOISE
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 2
m_cowardmenace_1:
    !byte N_VOI, 2
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP
m_cowardmenace_2:
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 3
    !byte N_JMS, <m_cowardmenace_b3, >m_cowardmenace_b3

m_cowardmenace_3:
    !byte N_JMS, <m_cowardmenace_b4, >m_cowardmenace_b4

m_cowardmenace_4:
    !byte N_JMS, <m_cowardmenace_b3, >m_cowardmenace_b3

m_cowardmenace_5:
    !byte N_JMS, <m_cowardmenace_b5, >m_cowardmenace_b5


m_cowardmenace_6:
    !byte N_INS, 2, I_LONG_SAW
    !byte N_JMS, <m_cowardmenace_b3, >m_cowardmenace_b3

m_cowardmenace_7:
    !byte N_JMS, <m_cowardmenace_b4, >m_cowardmenace_b4

m_cowardmenace_8:
    !byte N_JMS, <m_cowardmenace_b3, >m_cowardmenace_b3

m_cowardmenace_9:
    !byte N_JMS, <m_cowardmenace_b5, >m_cowardmenace_b5

m_cowardmenace_10:
    !byte N_INS, 0, I_LONG_TRIANGLE
    !byte N_VOI, 2
    !byte N_JMS, <m_cowardmenace_b9, >m_cowardmenace_b9

m_cowardmenace_11:
    !byte N_F4, N_D5
    !byte N_GNP
    !byte N_GNP
    !byte N_G4, N_NOP
    !byte N_NOP,N_D5
    !byte N_GNP
    !byte N_F4, N_NOP
    !byte N_E4, N_NOP

m_cowardmenace_12:
    !byte N_JMS, <m_cowardmenace_b9, >m_cowardmenace_b9
    !byte N_D4, N_D5
    !byte N_GNP
    !byte N_GNP
    !byte N_GNP

m_cowardmenace_end:
    !byte N_JMP, <music_idle, >music_idle


m_cowardmenace_b3:
    !byte N_D2, N_D5, N_D4
    !byte N_GNP
    !byte N_D2, N_NOP, N_NOP
    !byte N_NOP, N_NOP, N_E4
    !byte N_D2, N_D5, N_NOP
    !byte N_GNP
    !byte N_D2, N_NOP, N_C4
    !byte N_NOP, N_NOP, N_D4
    !byte N_RTS

m_cowardmenace_b4:
    !byte N_D2, N_D5, N_F4
    !byte N_GNP
    !byte N_D2, N_NOP, N_NOP
    !byte N_NOP, N_NOP, N_G4
    !byte N_D2, N_D5, N_NOP
    !byte N_GNP
    !byte N_D2, N_NOP, N_F4
    !byte N_NOP, N_NOP, N_E4
    !byte N_RTS

m_cowardmenace_b5:
    !byte N_D2, N_D5, N_D4
    !byte N_GNP
    !byte N_D2, N_NOP, N_STP
    !byte N_NOP, N_NOP, N_NOP
    !byte N_D2, N_D5, N_NOP
    !byte N_GNP
    !byte N_D2, N_NOP, N_NOP
    !byte N_NOP, N_NOP, N_NOP
    !byte N_RTS

m_cowardmenace_b9:
    !byte N_D4, N_D5
    !byte N_GNP
    !byte N_GNP
    !byte N_E4, N_NOP
    !byte N_NOP, N_D5
    !byte N_GNP
    !byte N_C4, N_NOP
    !byte N_D4, N_NOP
    !byte N_RTS