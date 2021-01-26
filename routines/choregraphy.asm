!ifndef is_main {
    !src "../../lib/x16.asm"
    !src "../../lib/math.asm"
    !src "../paper.asm"
    !src "game.asm"
    *=$801
}

CHOR_MODE_POSITION  = $00
CHOR_MODE_REMOTE_POS= $01

CHOR_OP_SLP = $00 ; SLeeP                   : amount
CHOR_OP_INS = $01 ; INSert object           : type, param
CHOR_OP_CHM = $02 ; CHange Mode             : mode
CHOR_OP_SPS = $03 ; Set PoSition (absolute) : pos_x, pos_y
CHOR_OP_MPS = $04 ; Move PoSition (relative): delta_x, delta_y
CHOR_OP_FPS = $05 ; Fast Move Position (rel): delta_xy
CHOR_OP_JMP = $F0 ; JuMP to address         : new_addr
CHOR_OP_JIZ = $F1 ; Jump If reg is Zero     : new_addr
CHOR_OP_JIN = $F2 ; Jump If reg is Not zero : new_addr
CHOR_OP_EXC = $FF ; EXeCute code            : address_l, address_y

run_choregraphy:
    ;handle sleeping
    lda choregraphy_sleep
    beq .chor_parse
    lda wait_frame
    bne +
    dec choregraphy_sleep
+   jmp .chor_end
.chor_parse   
    jsr .chor_next_byte
    ; get next step
    tay
    ; PROCESS OPCODES
    bne +
    ; CHOR_OP_SLP
    jsr .chor_next_byte
    sta choregraphy_sleep
    jmp .chor_end
+
    cmp #CHOR_OP_INS
    bne +
    ; CHOR_OP_INS
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
    ; TODO
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
    cmp #CHOR_OP_JIZ
    bne +
    ; TODO
    jmp .chor_end
+
    cmp #CHOR_OP_JIN
    bne +
    ; TODO
    jmp .chor_end
+
    cmp #CHOR_OP_EXC
    bne +
    ; TODO
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
+   cmp #CHOR_MODE_REMOTE_POS
    bne +
    ; MODE REMOTE POS
    ; //TODO
+   
    rts
; ##########################
.chor_next_byte:
    phx
    ldx #0
    lda (choregraphy_pc,X)
    +inc16 choregraphy_pc
    plx
    rts
; ##########################

.chor_end: