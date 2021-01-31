!ifndef is_main !eof

CHOR_MODE_POSITION = $00
CHOR_MODE_TRACKING = $01

CHOR_OP_SLP = $00 ; SLeeP                   : amount
CHOR_OP_INS = $01 ; INSert object           : type, param
CHOR_OP_BIS = $02 ; Bulk InSert             : count, (type, param,)
CHOR_OP_CHM = $03 ; CHange Mode             : mode
CHOR_OP_SPS = $04 ; Set PoSition (absolute) : pos_x, pos_y
CHOR_OP_MPS = $05 ; Move PoSition (relative): delta_x, delta_y
CHOR_OP_FPS = $06 ; Fast Move Position (rel): delta_xy
CHOR_OP_SRX = $07 ; Set Random X position   ;
CHOR_OP_SRY = $08 ; Set Random Y position   ;

CHOR_OP_PRT = $20 ; PRinT text              : pos_x, pos_y, str_addr_l, str_addr_h
CHOR_OP_PRD = $21 ; PRint Direct mode       : pos_x, pos_y, ...null_terminated_str
CHOR_OP_CHR = $22 ; print CHaR              : pos_x, pos_y, character
CHOR_OP_SBG = $23 ; Set BackGround          ; tile_id
CHOR_OP_SCR = $24 ; change SCRoll speed     ; speed

CHOR_OP_LDA = $30 ; LoaD regA               : immediate value
CHOR_OP_INA = $31 ; INcrement regA          : 
CHOR_OP_DEA = $32 ; DEcregment regA         :
CHOR_OP_LDB = $33 ; LoaD regB               : immediate value
CHOR_OP_INB = $34 ; INcrement regB          : 
CHOR_OP_DEB = $35 ; DEcregment regB         :

CHOR_OP_SPR = $A0 ; change SPRite           ; from, to, spid
CHOR_OP_MOB = $A1 ; Move OBject             ; obj_id, pos_x, pos_y
CHOR_OP_COB = $A2 ; Configure OBject        ; obj_id, type, param

CHOR_OP_JMP = $E0 ; JuMP to address         : addr_l, addr_h
CHOR_OP_JAZ = $E1 ; Jump If regA is Zero    : addr_l, addr_h
CHOR_OP_JAN = $E2 ; Jump If regA is Not zero: addr_l, addr_h
CHOR_OP_JBZ = $E3 ; Jump If regB is Zero    : addr_l, addr_h
CHOR_OP_JBN = $E4 ; Jump If regB is Not zero: addr_l, addr_h
CHOR_OP_JXZ = $E5 ; Jump if posX is Zero    : addr_l, addr_h
CHOR_OP_JYZ = $E6 ; Jump if posY is Zero    : addr_l, addr_h

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
    cmp #CHOR_OP_BIS
    bne +
        jsr .chor_set_pos
        jsr .chor_next_byte
        tax
        .op_bis_lp:
            jsr .chor_next_byte
            sta r_obj_t
            jsr .chor_next_byte
            sta r_obj_p
            phx
            jsr insert_object
            plx
            dex
            bne .op_bis_lp
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
    cmp #CHOR_OP_SRX
    bne +
        jsr rng
        sta choregraphy_pos_x
    jmp .chor_end
+
    cmp #CHOR_OP_SRY
    bne +
        jsr rng
        sta choregraphy_pos_y        
    jmp .chor_end
+
    cmp #CHOR_OP_PRT
    bne +
        jsr .chor_next_byte
        tay
        jsr .chor_next_byte
        tax
        clc
        jsr PLOT
        jsr .chor_next_byte
        sta x16_r0_l
        jsr .chor_next_byte
        sta x16_r0_h
        jsr print
    jmp .chor_end
+
    cmp #CHOR_OP_PRD
    bne +
        +fn_print str_white_on_black
        jsr .chor_next_byte
        tay
        jsr .chor_next_byte
        tax
        clc
        jsr PLOT
        .op_prd_lp:
            jsr .chor_next_byte
            beq .op_prd_end
            jsr CHROUT
            jmp .op_prd_lp
        .op_prd_end:
    jmp .chor_end
+
    cmp #CHOR_OP_CHR
    bne +
        +fn_print str_white_on_black
        jsr .chor_next_byte
        tay
        jsr .chor_next_byte
        tax
        clc
        jsr PLOT
        jsr .chor_next_byte
        jsr CHROUT
    jmp .chor_end
+
    cmp #CHOR_OP_SBG
    bne +
        jsr .chor_next_byte
        jsr fill_layer0
    jmp .chor_end
+
    cmp #CHOR_OP_SCR
    bne +
        jsr .chor_next_byte
        sta scroll_speed
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
    cmp #CHOR_OP_SPR
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        tay
        jsr .chor_next_byte
        jsr change_obj_sprite
    jmp .chor_end
+
    cmp #CHOR_OP_MOB
    bne +
        stz x16_r0_l
        stz x16_r0_h
        jsr .chor_next_byte
        tax
        -   clc
            +adc16 x16_r0, $04
            dex
            bne -
        lda #<obj_table+2
        clc
        adc x16_r0_l
        sta x16_r0_l
        lda #>obj_table
        adc x16_r0_h
        sta x16_r0_h
        jsr .chor_next_byte
        sta (x16_r0_l)
        +inc16 x16_r0
        jsr .chor_next_byte
        sta (x16_r0_l)
    jmp .chor_end
+
    cmp #CHOR_OP_COB
    bne +
        stz x16_r0_l
        stz x16_r0_h
        jsr .chor_next_byte
        tax
        -   clc
            +adc16 x16_r0, $04
            dex
            bne -
        lda #<obj_table
        clc
        adc x16_r0_l
        sta x16_r0_l
        lda #>obj_table
        adc x16_r0_h
        sta x16_r0_h
        jsr .chor_next_byte
        sta (x16_r0_l)
        +inc16 x16_r0
        jsr .chor_next_byte
        sta (x16_r0_l)
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
        bne .op_jaz_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jaz_end:
    jmp .chor_end
+
    cmp #CHOR_OP_JAN
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        ldy choregraphy_reg_a
        beq .op_jan_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jan_end:
    jmp .chor_end
+
    cmp #CHOR_OP_JBZ
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        ldy choregraphy_reg_b
        bne .op_jbz_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jbz_end:
    jmp .chor_end
+
    cmp #CHOR_OP_JBN
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        ldy choregraphy_reg_b
        beq .op_jbn_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jbn_end:
    jmp .chor_end
+
    cmp #CHOR_OP_JXZ
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        ldy choregraphy_pos_x
        bne .op_jxz_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jxz_end:
    jmp .chor_end
+
    cmp #CHOR_OP_JYZ
    bne +
        jsr .chor_next_byte
        tax
        jsr .chor_next_byte
        ldy choregraphy_pos_y
        bne .op_jyz_end
        sta choregraphy_pc_h
        txa
        sta choregraphy_pc_l
        .op_jyz_end:
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
    eor #$00               ; )- this line will recall the cpu status flag
    rts
; ##########################

.chor_end: