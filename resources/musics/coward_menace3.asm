!ifndef is_main !eof

; "Coward Menace"
; Original song by Vincent Foulon

m_cowardmenace3:
    !byte N_RTM, 15
    !byte N_INS, 0, I_TINY_LOW_NOISE
    !byte N_INS, 1, I_LONG_SAW
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 2
m_cowardmenace3_1:
    !byte N_VOI, 2
    !byte N_D4, N_D2
    !byte N_NOP,N_F2
    !byte N_A4, N_D2
    !byte N_NOP,N_F2
    !byte N_D4, N_C2
    !byte N_D4, N_E2
    !byte N_A4, N_C2
    !byte N_NOP,N_E2
m_cowardmenace3_2:
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 3
    !byte N_JMS, <m_cowardmenace3_b3, >m_cowardmenace3_b3

m_cowardmenace3_3:
    !byte N_JMS, <m_cowardmenace3_b4, >m_cowardmenace3_b4

m_cowardmenace3_4:
    !byte N_JMS, <m_cowardmenace3_b3, >m_cowardmenace3_b3

m_cowardmenace3_5:
    !byte N_JMS, <m_cowardmenace3_b5, >m_cowardmenace3_b5


m_cowardmenace3_6:
    !byte N_INS, 2, I_LONG_SAW
    !byte N_JMS, <m_cowardmenace3_b3, >m_cowardmenace3_b3

m_cowardmenace3_7:
    !byte N_JMS, <m_cowardmenace3_b4, >m_cowardmenace3_b4

m_cowardmenace3_8:
    !byte N_JMS, <m_cowardmenace3_b3, >m_cowardmenace3_b3

m_cowardmenace3_9:
    !byte N_JMS, <m_cowardmenace3_b5, >m_cowardmenace3_b5

m_cowardmenace3_10:
    !byte N_INS, 0, I_LONG_TRIANGLE
    !byte N_INS, 1, I_TINY_LOW_NOISE
    !byte N_VOI, 2
    !byte N_JMS, <m_cowardmenace3_b9, >m_cowardmenace3_b9

m_cowardmenace3_11:
    !byte N_F4, N_D4
    !byte N_NOP,N_NOP
    !byte N_NOP,N_A4
    !byte N_G4, N_NOP
    !byte N_NOP,N_D4
    !byte N_NOP,N_D4
    !byte N_F4, N_A4
    !byte N_E4, N_NOP

m_cowardmenace3_12:
    !byte N_JMS, <m_cowardmenace3_b9, >m_cowardmenace3_b9
    !byte N_D4, N_D4
    !byte N_GNP
    !byte N_GNP
    !byte N_GNP

m_cowardmenace3_end:
    !byte N_JMP, <music_idle, >music_idle


m_cowardmenace3_b3:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_NOP
    !byte N_NOP,N_F2, N_E4
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_C4
    !byte N_NOP,N_E2, N_D4
    !byte N_RTS

m_cowardmenace3_b4:
    !byte N_D4, N_D2, N_F4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_NOP
    !byte N_NOP,N_F2, N_G4
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_F4
    !byte N_NOP,N_E2, N_E4
    !byte N_RTS

m_cowardmenace3_b5:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_STP
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_NOP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_NOP
    !byte N_RTS

m_cowardmenace3_b9:
    !byte N_D4, N_D4
    !byte N_NOP,N_NOP
    !byte N_NOP,N_A4
    !byte N_E4, N_NOP
    !byte N_NOP,N_D4
    !byte N_NOP,N_D4
    !byte N_C4, N_A4
    !byte N_D4, N_NOP
    !byte N_RTS