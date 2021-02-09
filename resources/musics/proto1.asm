!ifndef is_main !eof

proto:
    ; blank loop, put the interpreter to sleep
    !byte N_RTM, 255
    !byte N_GNP
    !byte N_JMP, <proto, >proto

    !byte N_RTM, 15
    !byte N_INS, 0, 5
    !byte N_INS, 1, 4
    !byte N_INS, 2, 1
    !byte N_VOI, 1
    !byte N_JMS, <proto_s1, >proto_s1
    !byte N_JMS, <proto_s1, >proto_s1
proto_1:
    !byte N_VOI, 2
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP
proto_2:
    !byte N_VOI, 2
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_D6
    !byte N_GNP
    !byte N_D2, N_D5
    !byte N_GNP
    !byte N_D2, N_NOP
    !byte N_GNP

    !byte N_JMP, <proto_2, >proto_2

proto_s1:
    !byte N_D2
    !byte N_GNP
    !byte N_D2
    !byte N_GNP
    !byte N_D2
    !byte N_GNP
    !byte N_D2
    !byte N_GNP
    !byte N_RTS