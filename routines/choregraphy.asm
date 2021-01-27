!ifndef is_main !eof

CHOR_MODE_POSITION = $00
CHOR_MODE_TRACKING = $01

CHOR_OP_SLP = $00 ; SLeeP                   : amount
CHOR_OP_INS = $01 ; INSert object           : type, param
CHOR_OP_CHM = $02 ; CHange Mode             : mode
CHOR_OP_SPS = $03 ; Set PoSition (absolute) : pos_x, pos_y
CHOR_OP_MPS = $04 ; Move PoSition (relative): delta_x, delta_y
CHOR_OP_FPS = $05 ; Fast Move Position (rel): delta_xy
CHOR_OP_LOC = $20 ; LOCate text cursor      ; pos_x, pos_y
CHOR_OP_PRT = $21 ; PRinT text at txt cursor; string_addr
CHOR_OP_LDA = $30 ; LoaD regA               : immediate value
CHOR_OP_INA = $31 ; INcrement regA          : 
CHOR_OP_DEA = $32 ; DEcregment regA         :
CHOR_OP_LDB = $33 ; LoaD regB               : immediate value
CHOR_OP_INB = $34 ; INcrement regB          : 
CHOR_OP_DEB = $35 ; DEcregment regB         :
CHOR_OP_JMP = $E0 ; JuMP to address         : addr_l, addr_h
CHOR_OP_JAZ = $E1 ; Jump If regA is Zero    : addr_l, addr_h
CHOR_OP_JAN = $E2 ; Jump If regA is Not zero: addr_l, addr_h
CHOR_OP_JBZ = $E3 ; Jump If regA is Zero    : addr_l, addr_h
CHOR_OP_JBN = $E4 ; Jump If regA is Not zero: addr_l, addr_h
CHOR_OP_JXZ = $E5 ; Jump if posX is Zero    : addr_l, addr_h
CHOR_OP_JYZ = $E6 ; Jump if posY is Zero    : addr_l, addr_h
CHOR_OP_SGM = $FE ; Set Game Mode           : game_mode
CHOR_OP_EXC = $FF ; EXeCute code            : address_l, address_y

run_choregraphy:
    ;handle sleeping
    lda choregraphy_sleep
    beq .chor_parse
    lda wait_frame
    and #WFRAME_CHOR
    bne +
    lda wait_frame
    ora #WFRAME_CHOR
    sta wait_frame
    dec choregraphy_sleep
+   jmp .chor_end
.chor_parse   
    jsr .chor_next_byte     ; )- get opcode
    
    ; PROCESS OPCODES
;   cmp #CHOR_OP_SLP        ; )- it's zero so no need of this
    bne +
    jsr .chor_next_byte
    sta choregraphy_sleep
    jmp .chor_end
+
    cmp #CHOR_OP_INS
    bne +
    jsr .chor_set_pos
    jsr .chor_next_byte
    sta r_obj_t
    jsr .chor_next_byte
    sta r_obj_p
    jsr insert_object
    jmp .chor_end
+
    cmp #CHOR_OP_CHM
    bne +
    jsr .chor_next_byte
    sta choregraphy_mode
    jmp .chor_end
+
    cmp #CHOR_OP_SPS
    bne +
    jsr .chor_next_byte
    sta choregraphy_pos_x
    jsr .chor_next_byte
    sta choregraphy_pos_y
    jmp .chor_end
+   
    cmp #CHOR_OP_MPS
    bne +
    jsr .chor_next_byte
    clc
    adc choregraphy_pos_x
    sta choregraphy_pos_x
    jsr .chor_next_byte
    clc
    adc choregraphy_pos_y
    sta choregraphy_pos_y
    jmp .chor_end
+
    cmp #CHOR_OP_FPS
    bne +
    jsr .chor_next_byte
    tax
    +get_left
    clc
    adc choregraphy_pos_x
    sta choregraphy_pos_x
    txa
    +get_right
    clc
    adc choregraphy_pos_y
    sta choregraphy_pos_y
    jmp .chor_end
+
    cmp #CHOR_OP_LOC
    bne +
    jsr .chor_next_byte
    tay
    jsr .chor_next_byte
    tax
    jsr PLOT
    jmp .chor_end
+
    cmp #CHOR_OP_PRT
    bne +
    jsr .chor_next_byte
    sta x16_r0_l
    jsr .chor_next_byte
    sta x16_r0_h
    jsr print
    jmp .chor_end
+
    cmp #CHOR_OP_LDA
    bne +
    jsr .chor_next_byte
    sta choregraphy_reg_a
    jmp .chor_end
+
    cmp #CHOR_OP_INA
    bne +
    inc choregraphy_reg_a
    jmp .chor_end
+
    cmp #CHOR_OP_DEA
    bne +
    dec choregraphy_reg_a
    jmp .chor_end
+
    cmp #CHOR_OP_LDB
    bne +
    jsr .chor_next_byte
    sta choregraphy_reg_b
    jmp .chor_end
+
    cmp #CHOR_OP_INB
    bne +
    inc choregraphy_reg_b
    jmp .chor_end
+
    cmp #CHOR_OP_DEB
    bne +
    dec choregraphy_reg_b
    jmp .chor_end
+
    cmp #CHOR_OP_JMP
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte    
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JAZ
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_reg_a
    bne +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JAN
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_reg_a
    beq +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JBZ
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_reg_b
    bne +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JBN
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_reg_b
    beq +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JXZ
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_pos_x
    bne +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_JYZ
    bne +
    jsr .chor_next_byte
    tax
    jsr .chor_next_byte
    ldy choregraphy_pos_y
    bne +
    sta choregraphy_pc_h
    txa
    sta choregraphy_pc_l
    jmp .chor_end
+
    cmp #CHOR_OP_SGM
    bne +
    jsr .chor_next_byte
    sta game_mode
    jmp .chor_end
+
    cmp #CHOR_OP_EXC
    bne +
    jsr .chor_next_byte
    sta x16_r0_l
    jsr .chor_next_byte
    sta x16_r0_h
    jsr x16_r0
    jmp .chor_end
+
    jmp .chor_end

; ##########################
.chor_set_pos:
    lda choregraphy_mode
    bne +
    ; MODE POSITION
    lda choregraphy_pos_x
    sta r_obj_x
    lda choregraphy_pos_y
    sta r_obj_y
    rts
+   cmp #CHOR_MODE_TRACKING
    bne +
    ; MODE TRACKING
    ;lda (choregraphy_pos)
+   
    rts
; ##########################
.chor_next_byte:
    phx
    ldx #0
    lda (choregraphy_pc,X)
    +inc16 choregraphy_pc
    plx
    tay                     ; )- this line will recall the cpu status flag
    rts
; ##########################

.chor_end: