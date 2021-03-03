!ifndef is_main !eof

; "Moving Bytes"
; Original song by Vincent Foulon

m_movingbytes:
    !byte N_RTM, 15
    !byte N_INS, 0, I_TINY_NOISE
    !byte N_INS, 1, I_LONG_SAW
    !byte N_INS, 2, I_LONG_PULSE
m_movingbytes_1:
    !byte N_VOI, 1
    !byte N_D4
    !byte N_NOP
    !byte N_A4
    !byte N_NOP
    !byte N_D4
    !byte N_D4
    !byte N_A4
    !byte N_NOP
m_movingbytes_2:
    !byte N_VOI, 2
    !byte N_JMS, <m_movingbytes_drums, >m_movingbytes_drums
m_movingbytes_3:
    !byte N_JMS, <m_movingbytes_drums, >m_movingbytes_drums
m_movingbytes_4:
    !byte N_VOI, 3
    !byte N_JMS, <m_movingbytes_b3, >m_movingbytes_b3
m_movingbytes_5:
    !byte N_JMS, <m_movingbytes_b4, >m_movingbytes_b4
m_movingbytes_6:
    !byte N_JMS, <m_movingbytes_b3, >m_movingbytes_b3
m_movingbytes_7:
    !byte N_JMS, <m_movingbytes_b5, >m_movingbytes_b5
m_movingbytes_8:
    !byte N_JMS, <m_movingbytes_b3, >m_movingbytes_b3
m_movingbytes_9:
    !byte N_JMS, <m_movingbytes_b4, >m_movingbytes_b4
m_movingbytes_10:
    !byte N_JMS, <m_movingbytes_b5, >m_movingbytes_b5
m_movingbytes_11:
    !byte N_JMS, <m_movingbytes_b4, >m_movingbytes_b4
m_movingbytes_12:
    !byte N_JMS, <m_movingbytes_b6, >m_movingbytes_b6
m_movingbytes_13:
    !byte N_INS, 2, I_LONG_TRIANGLE
    !byte N_JMS, <m_movingbytes_b8, >m_movingbytes_b8
m_movingbytes_14:
    !byte N_JMS, <m_movingbytes_b9, >m_movingbytes_b9
m_movingbytes_15:
    !byte N_JMS, <m_movingbytes_b8, >m_movingbytes_b8
m_movingbytes_16:
    !byte N_JMS, <m_movingbytes_b10, >m_movingbytes_b10
m_movingbytes_17:
    !byte N_JMS, <m_movingbytes_b11, >m_movingbytes_b11
m_movingbytes_18:
    !byte N_VOI, 2
    !byte N_JMS, <m_movingbytes_drums, >m_movingbytes_drums
m_movingbytes_19:
    !byte N_JMS, <m_movingbytes_drums, >m_movingbytes_drums
m_movingbytes_20:
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 3
    !byte N_JMS, <m_movingbytes_b12, >m_movingbytes_b12
m_movingbytes_21:
    !byte N_JMS, <m_movingbytes_b13, >m_movingbytes_b13
m_movingbytes_22:
    !byte N_JMS, <m_movingbytes_b14, >m_movingbytes_b14
m_movingbytes_23:
    !byte N_JMS, <m_movingbytes_b15, >m_movingbytes_b15
m_movingbytes_24:
    !byte N_JMS, <m_movingbytes_b12, >m_movingbytes_b12
m_movingbytes_25:
    !byte N_JMS, <m_movingbytes_b13, >m_movingbytes_b13
m_movingbytes_26:
    !byte N_JMS, <m_movingbytes_b14, >m_movingbytes_b14
m_movingbytes_27:
    !byte N_JMS, <m_movingbytes_b15, >m_movingbytes_b15
m_movingbytes_28:
    !byte N_JMS, <m_movingbytes_b16, >m_movingbytes_b16
m_movingbytes_29:
    !byte N_JMS, <m_movingbytes_b17, >m_movingbytes_b17
m_movingbytes_30:
    !byte N_JMS, <m_movingbytes_b16, >m_movingbytes_b16
m_movingbytes_31:
    !byte N_JMS, <m_movingbytes_b18, >m_movingbytes_b18
m_movingbytes_32:
    !byte N_JMS, <m_movingbytes_b16, >m_movingbytes_b16
m_movingbytes_33:
    !byte N_JMS, <m_movingbytes_b17, >m_movingbytes_b17
m_movingbytes_34:
    !byte N_JMS, <m_movingbytes_b18, >m_movingbytes_b18
m_movingbytes_35:
    !byte N_JMS, <m_movingbytes_b17, >m_movingbytes_b17
m_movingbytes_36:
    !byte N_JMS, <m_movingbytes_b19, >m_movingbytes_b19
m_movingbytes_37:
    !byte N_INS, 2, I_LONG_SAW
    !byte N_JMS, <m_movingbytes_b8, >m_movingbytes_b8
m_movingbytes_38:
    !byte N_JMS, <m_movingbytes_b9, >m_movingbytes_b9
m_movingbytes_39:
    !byte N_JMS, <m_movingbytes_b8, >m_movingbytes_b8
m_movingbytes_40:
    !byte N_JMS, <m_movingbytes_b10, >m_movingbytes_b10
m_movingbytes_41:
    !byte N_JMS, <m_movingbytes_b11, >m_movingbytes_b11
m_movingbytes_42:
    !byte N_VOI, 2
    !byte N_INS, 1, I_LONG_TRIANGLE
    !byte N_JMS, <m_movingbytes_b24, >m_movingbytes_b24
m_movingbytes_43:
    !byte N_D4, N_D3
    !byte N_NOP,N_NOP
    !byte N_A4, N_D4
    !byte N_GNP
    !byte N_D4, N_A3
    !byte N_D4, N_E3
    !byte N_A4, N_NOP
    !byte N_NOP,N_F3
m_movingbytes_44:
    !byte N_JMS, <m_movingbytes_b24, >m_movingbytes_b24
m_movingbytes_45:
    !byte N_D4, N_D3
    !byte N_NOP,N_NOP
    !byte N_A4, N_G3
    !byte N_GNP
    !byte N_D4, N_A3
    !byte N_D4, N_E3
    !byte N_A4, N_NOP
    !byte N_NOP,N_C3
m_movingbytes_46:
    !byte N_INS, 0, I_LONG_TRIANGLE
    !byte N_D3, N_STP
    !byte N_VOI, 1
    !byte N_NOP
    !byte N_NOP
    !byte N_NOP
    !byte N_STP
    !byte N_NOP
    !byte N_NOP
    !byte N_NOP


m_movingbytes_end:
    !byte N_JMP, <music_idle, >music_idle



m_movingbytes_drums:
    !byte N_D4, N_D2
    !byte N_NOP,N_F2
    !byte N_A4, N_D2
    !byte N_NOP,N_F2
    !byte N_D4, N_C2
    !byte N_D4, N_E2
    !byte N_A4, N_C2
    !byte N_NOP,N_E2
    !byte N_RTS

m_movingbytes_b3:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_C3
    !byte N_RTS

m_movingbytes_b4:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_F3
    !byte N_RTS

m_movingbytes_b5:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_G3
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_C3
    !byte N_RTS

m_movingbytes_b6:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_NOP
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_STP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_NOP
    !byte N_RTS


m_movingbytes_b8:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_STP,N_D4
    !byte N_GNP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_STP,N_NOP
    !byte N_NOP,N_NOP,N_C3
    !byte N_RTS

m_movingbytes_b9:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_STP,N_D4
    !byte N_GNP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_STP,N_NOP
    !byte N_NOP,N_NOP,N_F3
    !byte N_RTS

m_movingbytes_b10:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_STP,N_G3
    !byte N_GNP
    !byte N_D4, N_C2, N_A3
    !byte N_D4, N_E2, N_E3
    !byte N_A4, N_STP,N_NOP
    !byte N_NOP,N_NOP,N_C3
    !byte N_RTS

m_movingbytes_b11:
    !byte N_D4, N_D2, N_D3
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_STP,N_NOP
    !byte N_GNP
    !byte N_D4, N_C2, N_STP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_STP,N_NOP
    !byte N_GNP
    !byte N_RTS


m_movingbytes_b12:
    !byte N_D4, N_D2, N_F4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_F4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_C4
    !byte N_RTS

m_movingbytes_b13:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D5
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_F4
    !byte N_RTS

m_movingbytes_b14:
    !byte N_D4, N_D2, N_F4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_F4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_A4
    !byte N_RTS

m_movingbytes_b15:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_NOP
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_STP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_NOP
    !byte N_RTS


m_movingbytes_b16:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D5
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_C4
    !byte N_RTS

m_movingbytes_b17:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_D5
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_F4
    !byte N_RTS

m_movingbytes_b18:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_G4
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_A4
    !byte N_D4, N_E2, N_E4
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_C4
    !byte N_RTS

m_movingbytes_b19:
    !byte N_D4, N_D2, N_D4
    !byte N_NOP,N_F2, N_NOP
    !byte N_A4, N_D2, N_NOP
    !byte N_NOP,N_F2, N_NOP
    !byte N_D4, N_C2, N_STP
    !byte N_D4, N_E2, N_NOP
    !byte N_A4, N_C2, N_NOP
    !byte N_NOP,N_E2, N_NOP
    !byte N_RTS

m_movingbytes_b24:
    !byte N_D4, N_D3
    !byte N_NOP,N_NOP
    !byte N_A4, N_D4
    !byte N_GNP
    !byte N_D4, N_A3
    !byte N_D4, N_E3
    !byte N_A4, N_NOP
    !byte N_NOP,N_C3
    !byte N_RTS