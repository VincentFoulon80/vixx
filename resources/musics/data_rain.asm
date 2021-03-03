!ifndef is_main !eof

; "Data Rain"
; Original song by Vincent Foulon

m_datarain:
    !byte N_RTM, 12
    !byte N_INS, 0, I_SHORT_PULSE
    !byte N_INS, 1, I_TINY_SAW
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_INS, 3, I_TINY_SAW
m_datarain_1:
    !byte N_VOI, 2
    !byte N_JMS, <m_datarain_s1, >m_datarain_s1
    !byte N_JMS, <m_datarain_s1, >m_datarain_s1
m_datarain_2:
    !byte N_VOI, 3
    !byte N_JMS, <m_datarain_s2, >m_datarain_s2
m_datarain_3:
    !byte N_D2, N_D1, N_D3
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_E3
    !byte N_GNP
    !byte N_D2, N_D1, N_A3
    !byte N_A2, N_NOP,N_D3
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
m_datarain_4:
    !byte N_JMS, <m_datarain_s3, >m_datarain_s3
m_datarain_5:
    !byte N_D2, N_D1, N_D4
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_D3
    !byte N_GNP
    !byte N_D2, N_D1, N_F3
    !byte N_A2, N_NOP,N_D4
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
m_datarain_6:
    !byte N_VOI, 4
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_E5, N_E5
    !byte N_GNP
    !byte N_D2, N_D1, N_A5, N_A5
    !byte N_A2, N_NOP,N_D5, N_D5
    !byte N_D2, N_D1, N_NOP,N_NOP
    !byte N_NOP,N_NOP,N_STP,N_STP
m_datarain_7:
    !byte N_VOI, 3
    !byte N_INS, 2, I_TINY_SAW
    !byte N_JMS, <m_datarain_s2, >m_datarain_s2

m_datarain_8:
    !byte N_VOI, 4
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP, N_NOP
    !byte N_D2, N_D1, N_D4, N_D4
    !byte N_GNP
    !byte N_D2, N_D1, N_F4, N_F4
    !byte N_A2, N_NOP,N_D5, N_D5
    !byte N_D2, N_D1, N_NOP, N_NOP
    !byte N_NOP,N_NOP,N_STP, N_STP
m_datarain_9:
    !byte N_VOI, 3
    !byte N_INS, 2, I_TINY_SAW
    !byte N_JMS, <m_datarain_s3, >m_datarain_s3
m_datarain_10:
    !byte N_VOI,2
    !byte N_INS, 0, I_LONG_PULSE
    !byte N_INS, 1, I_TINY_PULSE
    !byte N_D2, N_D3
    !byte N_NOP,N_D3
    !byte N_NOP,N_E3
    !byte N_STP,N_E3
    !byte N_D2, N_A3
    !byte N_INS, 1, I_LONG_PULSE
    !byte N_NOP,N_D3
    !byte N_NOP,N_STP
    !byte N_GSP
m_datarain_11:
    !byte N_D2, N_D3
    !byte N_GNP
    !byte N_NOP,N_E3
    !byte N_STP,N_NOP
    !byte N_D2, N_A3
    !byte N_NOP,N_D4
    !byte N_GNP
    !byte N_GSP
m_datarain_12:
    !byte N_INS, 1, I_TINY_PULSE
    !byte N_D2, N_D5
    !byte N_NOP,N_D5
    !byte N_NOP,N_D4
    !byte N_STP,N_D4
    !byte N_D2, N_F4
    !byte N_INS, 1, I_LONG_PULSE
    !byte N_NOP,N_D5
    !byte N_NOP,N_STP
    !byte N_GSP
m_datarain_13:
    !byte N_D2, N_A4
    !byte N_GNP
    !byte N_NOP,N_E4
    !byte N_STP,N_NOP
    !byte N_D2, N_A4
    !byte N_NOP,N_D4
    !byte N_GNP
    !byte N_GSP
m_datarain_14:
    !byte N_INS, 1, I_TINY_SAW
    !byte N_VOI, 2
    !byte N_JMS, <m_datarain_s1, >m_datarain_s1
m_datarain_15:
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_VOI, 3
    !byte N_D2, N_D1, N_D4
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_A4
    !byte N_GNP
    !byte N_D2, N_D1, N_E4
    !byte N_A2, N_NOP,N_D4
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
m_datarain_16:
    !byte N_VOI, 2
    !byte N_JMS, <m_datarain_s1, >m_datarain_s1
m_datarain_17:
    !byte N_VOI, 3
    !byte N_D2, N_D1, N_D5
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_F4
    !byte N_GNP
    !byte N_D2, N_D1, N_D4
    !byte N_A2, N_NOP,N_D5
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
m_datarain_18:
    !byte N_VOI, 2
    !byte N_JMS, <m_datarain_s1, >m_datarain_s1
m_datarain_19:
    !byte N_VOI, 1
    !byte N_JMS, <m_datarain_s8, >m_datarain_s8
m_datarain_20:
    !byte N_VOI, 4
    !byte N_INS, 2, I_TINY_LOW_NOISE
    !byte N_INS, 3, I_LONG_PULSE
    !byte N_JMS, <m_datarain_s4, >m_datarain_s4
    !byte N_JMS, <m_datarain_s4, >m_datarain_s4
m_datarain_21:
    !byte N_JMS, <m_datarain_s5, >m_datarain_s5
    !byte N_JMS, <m_datarain_s5, >m_datarain_s5
m_datarain_22:
    !byte N_JMS, <m_datarain_s6, >m_datarain_s6
    !byte N_JMS, <m_datarain_s6, >m_datarain_s6
m_datarain_23:
    !byte N_JMS, <m_datarain_s7, >m_datarain_s7
    !byte N_JMS, <m_datarain_s7, >m_datarain_s7
m_datarain_24:
    !byte N_VOI, 1
    !byte N_JMS, <m_datarain_s8, >m_datarain_s8
m_datarain_25:
    !byte N_VOI, 4
    !byte N_JMS, <m_datarain_s9, >m_datarain_s9
m_datarain_26:
    !byte N_JMS, <m_datarain_s10, >m_datarain_s10
m_datarain_27:
    !byte N_JMS, <m_datarain_s11, >m_datarain_s11
m_datarain_28:
    !byte N_D2, N_D1, N_D5, N_A4
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_E4
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_A4
    !byte N_A2, N_NOP,N_NOP,N_D4
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
m_datarain_29:
    !byte N_JMS, <m_datarain_s9, >m_datarain_s9
m_datarain_30:
    !byte N_JMS, <m_datarain_s11, >m_datarain_s11
m_datarain_31:
    !byte N_JMS, <m_datarain_s10, >m_datarain_s10
m_datarain_32:
    !byte N_D2, N_D1, N_D5, N_D3
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_E3
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_A3
    !byte N_A2, N_NOP,N_NOP,N_D3
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
m_datarain_33:
    !byte N_JMS, <m_datarain_s4, >m_datarain_s4
m_datarain_34:
    !byte N_JMS, <m_datarain_s5, >m_datarain_s5
m_datarain_35:
    !byte N_D2, N_D1, N_D5, N_D4
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_D3
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_F3
    !byte N_A2, N_NOP,N_NOP,N_D4
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
m_datarain_36:
    !byte N_INS, 3, I_TINY_SAW
    !byte N_JMS, <m_datarain_s4, >m_datarain_s4
m_datarain_37:
    !byte N_INS, 3, I_LONG_PULSE
    !byte N_JMS, <m_datarain_s7, >m_datarain_s7
m_datarain_38:
    !byte N_VOI, 1
    !byte N_JMS, <m_datarain_s8, >m_datarain_s8
m_datarain_39:
    !byte N_VOI, 3
    !byte N_INS, 0, I_LONG_PULSE
    !byte N_INS, 1, I_TINY_LOW_NOISE
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_D2, N_D5, N_D4
    !byte N_GNP
    !byte N_NOP,N_A5, N_A4
    !byte N_STP,N_NOP,N_NOP
    !byte N_D2, N_D5, N_F4
    !byte N_NOP,N_NOP,N_D4
    !byte N_NOP,N_A5, N_NOP
    !byte N_STP,N_NOP,N_STP
m_datarain_40:
    !byte N_D2, N_D5, N_D5
    !byte N_GNP
    !byte N_NOP,N_A5, N_F4
    !byte N_STP,N_NOP,N_NOP
    !byte N_D2, N_D5, N_D4
    !byte N_NOP,N_NOP,N_D5
    !byte N_NOP,N_A5, N_NOP
    !byte N_STP,N_NOP,N_STP
m_datarain_41:
    !byte N_D2, N_D5, N_D5
    !byte N_GNP
    !byte N_NOP,N_A5, N_E5
    !byte N_STP,N_NOP,N_NOP
    !byte N_D2, N_D5, N_A5
    !byte N_NOP,N_NOP,N_D5
    !byte N_NOP,N_A5, N_NOP
    !byte N_STP,N_NOP,N_STP
m_datarain_42:
    !byte N_D2, N_D5, N_A4
    !byte N_GNP
    !byte N_NOP,N_A5, N_E4
    !byte N_STP,N_NOP,N_NOP
    !byte N_D2, N_D5, N_A4
    !byte N_NOP,N_NOP,N_D4
    !byte N_NOP,N_A5, N_NOP
    !byte N_STP,N_NOP,N_STP
m_datarain_43:
    !byte N_VOI, 2
    !byte N_INS, 0, I_TINY_LOW_NOISE
    !byte N_INS, 1, I_LONG_PULSE
    !byte N_D5, N_D3
    !byte N_GNP
    !byte N_A5, N_E3
    !byte N_NOP,N_NOP
    !byte N_D5, N_A3
    !byte N_NOP,N_D3
    !byte N_A5, N_NOP
    !byte N_NOP,N_STP
m_datarain_44:
    !byte N_VOI, 1
    !byte N_INS, 0, I_TINY_PULSE
    !byte N_D5
    !byte N_NOP
    !byte N_E5
    !byte N_NOP
    !byte N_A5
    !byte N_D5
    !byte N_NOP
    !byte N_STP

    !byte N_INS, 0, I_SHORT_PULSE
    !byte N_INS, 1, I_TINY_SAW
    !byte N_INS, 2, I_LONG_PULSE
    !byte N_INS, 3, I_TINY_SAW
;    !byte N_JMP, <m_datarain_19, >m_datarain_19
    !byte N_JMP, <music_idle, >music_idle

m_datarain_s1:
    !byte N_D2, N_D1
    !byte N_NOP,N_D2
    !byte N_D2, N_D1
    !byte N_GNP
    !byte N_D2, N_D1
    !byte N_A2, N_NOP
    !byte N_D2, N_D1
    !byte N_GNP
    !byte N_RTS

m_datarain_s2:
    !byte N_D2, N_D1, N_D5
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_E5
    !byte N_GNP
    !byte N_D2, N_D1, N_A5
    !byte N_A2, N_NOP,N_D5
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s3:
    !byte N_D2, N_D1, N_D5
    !byte N_NOP,N_D2, N_NOP
    !byte N_D2, N_D1, N_D4
    !byte N_GNP
    !byte N_D2, N_D1, N_F4
    !byte N_A2, N_NOP,N_D5
    !byte N_D2, N_D1, N_NOP
    !byte N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s4:
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_E5
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_A5
    !byte N_A2, N_NOP,N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s5:
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_D4
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_F4
    !byte N_A2, N_NOP,N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s6:
    !byte N_INS, 3, I_TINY_PULSE
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_E5
    !byte N_NOP,N_NOP,N_NOP,N_E5
    !byte N_D2, N_D1, N_D5, N_A5
    !byte N_INS, 3, I_LONG_PULSE
    !byte N_A2, N_NOP,N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s7:
    !byte N_INS, 3, I_TINY_PULSE
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_D4
    !byte N_NOP,N_NOP,N_NOP,N_D4
    !byte N_D2, N_D1, N_D5, N_F4
    !byte N_INS, 3, I_LONG_PULSE
    !byte N_A2, N_NOP,N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s8:
    !byte N_RTM, 20
    !byte N_D4
    !byte N_D4
    !byte N_D4
    !byte N_D4
    !byte N_D4
    !byte N_RTM, 12
    !byte N_GSP
    !byte N_RTS

m_datarain_s9:
    !byte N_D2, N_D1, N_D5, N_D4
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_A4
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_E4
    !byte N_A2, N_NOP,N_NOP,N_D4
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s10:
    !byte N_D2, N_D1, N_D5, N_D5
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_E4
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_D4
    !byte N_A2, N_NOP,N_NOP,N_D5
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS

m_datarain_s11:
    !byte N_D2, N_D1, N_D5, N_D3
    !byte N_NOP,N_D2, N_NOP,N_NOP
    !byte N_D2, N_D1, N_A5, N_E3
    !byte N_GNP
    !byte N_D2, N_D1, N_D5, N_A3
    !byte N_A2, N_NOP,N_NOP,N_D4
    !byte N_D2, N_D1, N_A5, N_NOP
    !byte N_NOP,N_NOP,N_NOP,N_STP
    !byte N_RTS