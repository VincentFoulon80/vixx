!ifndef is_main !eof

; "Seeking"
; Original song by Vincent Foulon

m_seeking:
    !byte N_RTM, 12
    !byte N_INS, 0, I_TINY_PULSE
    !byte N_INS, 1, I_LONG_SAW
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_INS, 3, I_LONG_PULSE
    !byte N_VOI, 1
m_seeking_1:
    !byte N_D1
    !byte N_NOP
    !byte N_D1
    !byte N_NOP
    !byte N_D1
    !byte N_NOP
    !byte N_D1
    !byte N_NOP
m_seeking_2:
    !byte N_VOI, 2
    !byte N_JMS, <m_seeking_s1, >m_seeking_s1
    !byte N_JMS, <m_seeking_s1, >m_seeking_s1
    !byte N_JMS, <m_seeking_s1, >m_seeking_s1
    !byte N_JMS, <m_seeking_s1, >m_seeking_s1
m_seeking_3:
    !byte N_VOI, 3
    !byte N_JMS, <m_seeking_sp2, >m_seeking_sp2
    !byte N_JMS, <m_seeking_s2, >m_seeking_s2
    !byte N_JMS, <m_seeking_sp2, >m_seeking_sp2
    !byte N_JMS, <m_seeking_s3, >m_seeking_s3
    !byte N_JMS, <m_seeking_sp2, >m_seeking_sp2
    !byte N_JMS, <m_seeking_s2, >m_seeking_s2
    !byte N_JMS, <m_seeking_sp2, >m_seeking_sp2
    !byte N_JMS, <m_seeking_s3, >m_seeking_s3
m_seeking_4:
    !byte N_D1, N_C2, N_C3
    !byte N_GNP
    !byte N_D1, N_NOP,N_G3
    !byte N_GNP
    !byte N_D1, N_DS2,N_F3
    !byte N_NOP,N_F2, N_G3
    !byte N_D1, N_G2, N_NOP
    !byte N_NOP,N_C2, N_B3
m_seeking_5:
    !byte N_JMS, <m_seeking_sp4, >m_seeking_sp4
    !byte N_JMS, <m_seeking_s4, >m_seeking_s4
    !byte N_JMS, <m_seeking_sp4, >m_seeking_sp4
    !byte N_JMS, <m_seeking_s5, >m_seeking_s5
    !byte N_JMS, <m_seeking_sp4, >m_seeking_sp4
    !byte N_JMS, <m_seeking_s4, >m_seeking_s4
    !byte N_JMS, <m_seeking_sp4, >m_seeking_sp4
    !byte N_JMS, <m_seeking_s5, >m_seeking_s5
m_seeking_6:
    !byte N_D1, N_C2, N_C4
    !byte N_GNP
    !byte N_D1, N_NOP,N_C3
    !byte N_GNP
    !byte N_D1, N_DS2,N_C4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D1, N_G2, N_C3
    !byte N_NOP,N_C2, N_NOP
    !byte N_JMS, <m_seeking_s10, >m_seeking_s10
m_seeking_7:
    !byte N_VOI, 4
    !byte N_JMS, <m_seeking_sp6, >m_seeking_sp6
    !byte N_JMS, <m_seeking_s6, >m_seeking_s6
    !byte N_JMS, <m_seeking_sp6, >m_seeking_sp6
    !byte N_JMS, <m_seeking_s7, >m_seeking_s7
    !byte N_JMS, <m_seeking_sp6, >m_seeking_sp6
    !byte N_JMS, <m_seeking_s6, >m_seeking_s6
    !byte N_JMS, <m_seeking_sp6, >m_seeking_sp6
    !byte N_JMS, <m_seeking_s7, >m_seeking_s7
m_seeking_8:
    !byte N_D1, N_C2, N_C3, N_C4
    !byte N_GNP
    !byte N_D1, N_NOP,N_G3, N_G4
    !byte N_GNP
    !byte N_D1, N_DS2,N_F3, N_F4
    !byte N_NOP,N_F2, N_G3, N_G4
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_B3, N_B4
m_seeking_9:
    !byte N_JMS, <m_seeking_sp8, >m_seeking_sp8
    !byte N_JMS, <m_seeking_s8, >m_seeking_s8
    !byte N_JMS, <m_seeking_sp8, >m_seeking_sp8
    !byte N_JMS, <m_seeking_s9, >m_seeking_s9
    !byte N_JMS, <m_seeking_sp8, >m_seeking_sp8
    !byte N_JMS, <m_seeking_s8, >m_seeking_s8
    !byte N_JMS, <m_seeking_sp8, >m_seeking_sp8
    !byte N_JMS, <m_seeking_s9, >m_seeking_s9
m_seeking_10:
    !byte N_D1, N_C2, N_C4, N_C5
    !byte N_GNP
    !byte N_D1, N_NOP,N_G4, N_G5
    !byte N_GNP
    !byte N_D1, N_DS2,N_F4, N_F5
    !byte N_NOP,N_F2, N_G4, N_G5
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_B4, N_B5
m_seeking_11:
    !byte N_D1, N_C2, N_C4, N_C6
    !byte N_GNP
    !byte N_D1, N_NOP,N_C3, N_NOP
    !byte N_GNP
    !byte N_D1, N_DS2,N_C4, N_NOP
    !byte N_NOP,N_F2, N_NOP,N_NOP
    !byte N_D1, N_G2, N_C3, N_NOP
    !byte N_NOP,N_C2, N_NOP,N_STP
    !byte N_VOI, 3
    !byte N_JMS, <m_seeking_s10, >m_seeking_s10

    !byte N_JMP, <m_seeking_3, >m_seeking_3


m_seeking_s1:
    !byte N_D1, N_C2
    !byte N_GNP
    !byte N_D1, N_NOP 
    !byte N_GNP
    !byte N_D1, N_DS2
    !byte N_NOP,N_F2
    !byte N_D1, N_G2
    !byte N_NOP,N_C2
    !byte N_RTS


m_seeking_sp2:
    !byte N_D1, N_C2, N_C3
    !byte N_GNP
    !byte N_D1, N_NOP,N_G3
    !byte N_GNP
    !byte N_D1, N_DS2,N_D3
    !byte N_RTS

m_seeking_s2:
    !byte N_NOP,N_F2, N_DS3
    !byte N_D1, N_G2, N_NOP
    !byte N_NOP,N_C2, N_D3
    !byte N_RTS

m_seeking_s3:
    !byte N_NOP,N_F2, N_F3
    !byte N_D1, N_G2, N_NOP
    !byte N_NOP,N_C2, N_DS3
    !byte N_RTS

m_seeking_sp4:
    !byte N_D1, N_C2, N_C4
    !byte N_GNP
    !byte N_D1, N_NOP,N_G4
    !byte N_GNP
    !byte N_D1, N_DS2,N_D4
    !byte N_RTS

m_seeking_s4:
    !byte N_NOP,N_F2, N_DS4
    !byte N_D1, N_G2, N_NOP
    !byte N_NOP,N_C2, N_D4
    !byte N_RTS

m_seeking_s5:
    !byte N_NOP,N_F2, N_F4
    !byte N_D1, N_G2, N_NOP
    !byte N_NOP,N_C2, N_DS4
    !byte N_RTS

m_seeking_sp6:
    !byte N_D1, N_C2, N_C3, N_C4
    !byte N_GNP
    !byte N_D1, N_NOP,N_G3, N_G4
    !byte N_GNP
    !byte N_D1, N_DS2,N_D3, N_D4
    !byte N_RTS

m_seeking_s6:
    !byte N_NOP,N_F2, N_DS3,N_DS4
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_D3, N_D4
    !byte N_RTS

m_seeking_s7:
    !byte N_NOP,N_F2, N_F3, N_F4
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_DS3,N_DS4
    !byte N_RTS

m_seeking_sp8:
    !byte N_D1, N_C2, N_C4, N_C5
    !byte N_GNP
    !byte N_D1, N_NOP,N_G4, N_G5
    !byte N_GNP
    !byte N_D1, N_DS2,N_D4, N_D5
    !byte N_RTS

m_seeking_s8:
    !byte N_NOP,N_F2, N_DS4,N_DS5
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_D4, N_D5
    !byte N_RTS

m_seeking_s9:
    !byte N_NOP,N_F2, N_F4, N_F5
    !byte N_D1, N_G2, N_NOP,N_NOP
    !byte N_NOP,N_C2, N_DS4,N_DS5
    !byte N_RTS

m_seeking_s10:
    !byte N_D1, N_C2, N_C4
    !byte N_NOP,N_NOP,N_C3
    !byte N_D1, N_NOP,N_C4
    !byte N_NOP,N_NOP,N_C3
    !byte N_D1, N_DS2,N_C4
    !byte N_NOP,N_F2, N_C3
    !byte N_D1, N_G2, N_C4
    !byte N_NOP,N_C2, N_STP
    !byte N_RTS