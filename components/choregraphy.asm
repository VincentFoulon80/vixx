!ifndef is_main !eof

CHOR_MODE_POSITION = $00
CHOR_MODE_TRACKING = $01

CHOR_OP_SLP = $00 ; SLeeP                   : amount
CHOR_OP_INS = $01 ; INSert object           : type, param
CHOR_OP_BIS = $02 ; Bulk InSert             : count, (type, param,)
CHOR_OP_ISP = $03 ; INSert at Position      : pos_x, pos_y, type, param
CHOR_OP_SPS = $04 ; Set PoSition (absolute) : pos_x, pos_y
CHOR_OP_MPS = $05 ; Move PoSition (relative): delta_x, delta_y
CHOR_OP_FPS = $06 ; Fast Move Position (rel): delta_xy
CHOR_OP_SRX = $07 ; Set Random X position   :
CHOR_OP_SRY = $08 ; Set Random Y position   :
CHOR_OP_SEK = $09 ; SEeK object position    : obj_id
CHOR_OP_SKX = $0A ; SeeK object X position  : obj_id
CHOR_OP_SKY = $0B ; SeeK object Y position  : obj_id

CHOR_OP_PRT = $20 ; PRinT text              : pos_x, pos_y, str_addr_l, str_addr_h
CHOR_OP_PRD = $21 ; PRint Direct mode       : pos_x, pos_y, ...null_terminated_str
CHOR_OP_CHR = $22 ; print CHaR              : pos_x, pos_y, character
CHOR_OP_SBG = $23 ; Set BackGround          ; tile_id
CHOR_OP_SCR = $24 ; change SCRoll speed     ; speed
CHOR_OP_MUS = $25 ; change music            ; addr_l, addr_h

CHOR_OP_LDA = $30 ; LoaD regA               : immediate value
CHOR_OP_INA = $31 ; INcrement regA          : 
CHOR_OP_DEA = $32 ; DEcregment regA         :
CHOR_OP_LDB = $33 ; LoaD regB               : immediate value
CHOR_OP_INB = $34 ; INcrement regB          : 
CHOR_OP_DEB = $35 ; DEcregment regB         :
CHOR_OP_LDC = $36 ; LoaD regC               : immediate value
CHOR_OP_INC = $37 ; INcrement regC          : 
CHOR_OP_DEC = $38 ; DEcregment regC         :

CHOR_OP_SPR = $A0 ; change SPRite           ; from, count, spid
CHOR_OP_MOJ = $A1 ; Move OBject             ; obj_id, pos_x, pos_y
CHOR_OP_MOA = $A2 ; Move Object on A        ; offset, type, param
CHOR_OP_COJ = $A3 ; Configure OBject        ; obj_id, type, param
CHOR_OP_COA = $A4 ; Configure Object on A   ; offset, type, param
CHOR_OP_CMO = $A5 ; Config. Multiple Objects; from, count, type, param

CHOR_OP_SCO = $B0 ; SCOre points            ; XX0000,XX00,XX
CHOR_OP_SOT = $B1 ; set Score Over Time     ; score
CHOR_OP_LIF = $B2 ; Give a life             ; 
CHOR_OP_PNC = $B3 ; Give a panic            ; 

CHOR_OP_JMP = $E0 ; JuMP to address         : addr_l, addr_h
CHOR_OP_JAZ = $E1 ; Jump if regA is Zero    : addr_l, addr_h
CHOR_OP_JAN = $E2 ; Jump if regA is Not zero: addr_l, addr_h
CHOR_OP_JBZ = $E3 ; Jump if regB is Zero    : addr_l, addr_h
CHOR_OP_JBN = $E4 ; Jump if regB is Not zero: addr_l, addr_h
CHOR_OP_JCZ = $E5 ; Jump if regC is Zero    : addr_l, addr_h
CHOR_OP_JCN = $E6 ; Jump if regC is Not zero: addr_l, addr_h
CHOR_OP_JRN = $E7 ; Jump RaNdomly           : addr_l, addr_h
CHOR_OP_JEM = $E8 ; Jump if Easy Mode       : addr_l, addr_h
CHOR_OP_JNE = $E9 ; Jump if Not Easy mode   : addr_l, addr_h
CHOR_OP_JNH = $EA ; Jump if Not Hard mode   : addr_l, addr_h
CHOR_OP_JHM = $EB ; Jump if Hard Mode       : addr_l, addr_h

CHOR_OP_EXC = $FF ; EXeCute code            : address_l, address_y

run_choregraphy:
    lda choregraphy_sleep   ; \
    beq .chor_parse         ;  |
    lda wait_frame          ;  |- handle sleeping
    and #WFRAME_CHOR        ;  |
    bne +                   ;  |
    lda wait_frame          ;  |
    ora #WFRAME_CHOR        ;  |
    sta wait_frame          ;  |
    dec choregraphy_sleep   ;  |
+   jmp .chor_end           ; /
.chor_parse   
    jsr .chor_next_byte     ; )- get opcode
    
    ; PROCESS OPCODES
;   cmp #CHOR_OP_SLP        ; )- it's zero so no need of this
    bne +                       ; \
        jsr .chor_next_byte     ;  |- SLEEP( amount )
        sta choregraphy_sleep   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_INS            ; \
    bne +                       ;  |- INSERT OBJECT ( type, param )
        jsr .chor_set_pos       ;  |
        jsr .chor_next_byte     ;  |
        sta r_obj_t             ;  |
        jsr .chor_next_byte     ;  |
        sta r_obj_p             ;  |
        jsr insert_object       ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_BIS            ; \
    bne +                       ;  |- BULK INSERT ( count, [(type, param)])
        jsr .chor_set_pos       ;  |
        jsr .chor_next_byte     ;  |
        tax                     ;  |
        .op_bis_lp:             ;  |
            jsr .chor_next_byte ;  |
            sta r_obj_t         ;  |
            jsr .chor_next_byte ;  |
            sta r_obj_p         ;  |
            phx                 ;  |
            jsr insert_object   ;  |
            plx                 ;  |
            dex                 ;  |
            bne .op_bis_lp      ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_ISP            ; \
    bne +                       ;  |- INSERT AT POS ( pos_x, pos_y, type, param )
        jsr .chor_next_byte     ;  |
        sta r_obj_x             ;  |
        jsr .chor_next_byte     ;  |
        sta r_obj_y             ;  |
        jsr .chor_next_byte     ;  |
        sta r_obj_t             ;  |
        jsr .chor_next_byte     ;  |
        sta r_obj_p             ;  |
        jsr insert_object       ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SPS            ; \
    bne +                       ;  |- SET POSITION ( pos_x, pos_y )
        jsr .chor_next_byte     ;  |
        sta choregraphy_pos_x   ;  |
        jsr .chor_next_byte     ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+   
    cmp #CHOR_OP_MPS            ; \
    bne +                       ;  |- MOVE POSITION ( delta_x, delta_y )
        jsr .chor_next_byte     ;  |
        clc                     ;  |
        adc choregraphy_pos_x   ;  |
        sta choregraphy_pos_x   ;  |
        jsr .chor_next_byte     ;  |
        clc                     ;  |
        adc choregraphy_pos_y   ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_FPS            ; \
    bne +                       ;  |- FAST MOVE POSITION ( delta_xy )
        jsr .chor_next_byte     ;  |
        tax                     ;  |
        +get_left               ;  |
        clc                     ;  |
        adc choregraphy_pos_x   ;  |
        sta choregraphy_pos_x   ;  |
        txa                     ;  |
        +get_right              ;  |
        clc                     ;  |
        adc choregraphy_pos_y   ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SRX            ; \
    bne +                       ;  |- SET RANDOM X POSITION ()
        jsr rng                 ;  |
        sta choregraphy_pos_x   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SRY            ; \
    bne +                       ;  |- SET RANDOM Y POSITION ()
        jsr rng                 ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SEK            ; \
    bne +                       ;  |- SEEK OBJECT POSITION ( obj_id )
        stz x16_r0_l            ;  |
        stz x16_r0_h            ;  |
        jsr .chor_next_byte     ;  | \
        tax                     ;  |  |
        -   clc                 ;  |  |
            +adc16 x16_r0, $04  ;  |  |- find the object's address
            dex                 ;  |  |
            bne -               ;  | /
        lda #<obj_table+2       ;  | \
        clc                     ;  |  |
        adc x16_r0_l            ;  |  |- load the object address into
        sta x16_r0_l            ;  |  |  x16_r0
        lda #>obj_table         ;  |  |
        adc x16_r0_h            ;  |  |
        sta x16_r0_h            ;  | /
        lda (x16_r0_l)          ;  |
        sta choregraphy_pos_x   ;  |
        +inc16 x16_r0           ;  |
        lda (x16_r0_l)          ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SKX            ; \
    bne +                       ;  |- SEEK OBJECT X POSITION ( obj_id )
        stz x16_r0_l            ;  |
        stz x16_r0_h            ;  |
        jsr .chor_next_byte     ;  | \
        tax                     ;  |  |
        beq .op_skx_skip        ;  |  |
        -   clc                 ;  |  |
            +adc16 x16_r0, $04  ;  |  |- find the object's address
            dex                 ;  |  |
            bne -               ;  | /
        .op_skx_skip:           ;  |
        lda #<obj_table+2       ;  | \
        clc                     ;  |  |
        adc x16_r0_l            ;  |  |- load the object address into
        sta x16_r0_l            ;  |  |  x16_r0
        lda #>obj_table         ;  |  |
        adc x16_r0_h            ;  |  |
        sta x16_r0_h            ;  | /
        lda (x16_r0_l)          ;  |
        sta choregraphy_pos_x   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_SKY            ; \
    bne +                       ;  |- SEEK OBJECT Y POSITION ( obj_id )
        stz x16_r0_l            ;  |
        stz x16_r0_h            ;  |
        jsr .chor_next_byte     ;  | \
        tax                     ;  |  |
        beq .op_sky_skip        ;  |  |
        -   clc                 ;  |  |
            +adc16 x16_r0, $04  ;  |  |- find the object's address
            dex                 ;  |  |
            bne -               ;  | /
        .op_sky_skip:           ;  |
        lda #<obj_table+3       ;  | \
        clc                     ;  |  |
        adc x16_r0_l            ;  |  |- load the object address into
        sta x16_r0_l            ;  |  |  x16_r0
        lda #>obj_table         ;  |  |
        adc x16_r0_h            ;  |  |
        sta x16_r0_h            ;  | /
        lda (x16_r0_l)          ;  |
        sta choregraphy_pos_y   ;  |
    jmp .chor_end               ; /
+
    cmp #CHOR_OP_PRT                ; \
    bne +                           ;  |- PRINT TEXT ( pos_x, pos_y, str_addr_l, str_addr_h )
        +fn_print str_white_on_black;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        clc                         ;  |
        jsr PLOT                    ;  |
        jsr .chor_next_byte         ;  |
        sta x16_r0_l                ;  |
        jsr .chor_next_byte         ;  |
        sta x16_r0_h                ;  |
        jsr print                   ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_PRD                ; \
    bne +                           ;  |- PRINT DIRECT MODE ( pos_x, pos_y, ...null_terminated_str )
        +fn_print str_white_on_black;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        clc                         ;  |
        jsr PLOT                    ;  |
        .op_prd_lp:                 ;  |
            jsr .chor_next_byte     ;  |
            beq .op_prd_end         ;  |
            jsr CHROUT              ;  |
            jmp .op_prd_lp          ;  |
        .op_prd_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_CHR                ; \
    bne +                           ;  |- PRINT CHARACTER ( pos_x, pos_y, character )
        +fn_print str_white_on_black;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        clc                         ;  |
        jsr PLOT                    ;  |
        jsr .chor_next_byte         ;  |
        jsr CHROUT                  ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_SBG                ; \
    bne +                           ;  |- SET BACKGROUND ( tile_id )
        jsr .chor_next_byte         ;  |
        jsr fill_layer0             ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_SCR                ; \
    bne +                           ;  |- SET SCROLL SPEED ( speed )
        jsr .chor_next_byte         ;  |
        sta scroll_speed            ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_MUS                ; \
    bne +                           ;  |- CHANGE MUSIC ( addr_l, addr_h )
        jsr .chor_next_byte         ;  |
        sta composer_pc_l           ;  |
        jsr .chor_next_byte         ;  |
        sta composer_pc_h           ;  |
        lda #$3B                    ;  |
        sta composer_delay          ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_LDA                ; \
    bne +                           ;  |- LOAD REGISTER A ( immediate_val )
        jsr .chor_next_byte         ;  |
        sta choregraphy_reg_a       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_INA                ; \
    bne +                           ;  |- INCREMENT REGISTER A ()
        inc choregraphy_reg_a       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_DEA                ; \
    bne +                           ;  |- DECREMENT REGISTER A ()
        dec choregraphy_reg_a       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_LDB                ; \
    bne +                           ;  |- LOAD REGISTER B ( immediate_val )
    jsr .chor_next_byte             ;  |
        sta choregraphy_reg_b       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_INB                ; \
    bne +                           ;  |- INCREMENT REGISTER B ()
        inc choregraphy_reg_b       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_DEB                ; \
    bne +                           ;  |- DECREMENT REGISTER B ()
        dec choregraphy_reg_b       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_LDC                ; \
    bne +                           ;  |- LOAD REGISTER C ( immediate_val )
    jsr .chor_next_byte             ;  |
        sta choregraphy_reg_c       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_INC                ; \
    bne +                           ;  |- INCREMENT REGISTER C ()
        inc choregraphy_reg_c       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_DEC                ; \
    bne +                           ;  |- DECREMENT REGISTER C ()
        dec choregraphy_reg_c       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_SPR                ; \
    bne +                           ;  |- CHANGE SPRITE ( from, count, spid )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        jsr .chor_next_byte         ;  |
        jsr change_obj_sprite       ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_MOJ                ; \
    bne +                           ;  |- MOVE OBJECT ( obj_id, pos_y, pos_x )
        stz x16_r0_l                ;  |
        stz x16_r0_h                ;  |
        jsr .chor_next_byte         ;  | \
    .op_moj_entry:                  ;  |  |
        tax                         ;  |  |
        and #$7F                    ;  |  | )- limit to 127 first
        -   clc                     ;  |  |
            +adc16 x16_r0, $04      ;  |  |- find the object's address
            dex                     ;  |  |
            bne -                   ;  | /
        lda #<obj_table+2           ;  | \
        clc                         ;  |  |
        adc x16_r0_l                ;  |  |- load the object address into
        sta x16_r0_l                ;  |  |  x16_r0
        lda #>obj_table             ;  |  |
        adc x16_r0_h                ;  |  |
        sta x16_r0_h                ;  | /
        jsr .chor_next_byte         ;  | \
        sta (x16_r0_l)              ;  |  |- change object's position
        +inc16 x16_r0               ;  |  |
        jsr .chor_next_byte         ;  |  |
        sta (x16_r0_l)              ;  | /
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_MOA                ; \
    bne +                           ;  |- MOVE OBJECT ON A ( offset, type, param )
        stz x16_r0_l                ;  |
        stz x16_r0_h                ;  |
        jsr .chor_next_byte         ;  |
        clc                         ;  |
        adc choregraphy_reg_a       ;  |
        bra .op_moj_entry           ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_COJ                ; \
    bne +                           ;  |- CONFIGURE OBJECT ( obj_id, type, param )
        stz x16_r0_l                ;  |
        stz x16_r0_h                ;  |
        jsr .chor_next_byte         ;  | \
    .op_coj_entry:                  ;  |  |
        and #$7F                    ;  |  | )- limit to 127 first
        tax                         ;  |  |
        -   clc                     ;  |  |
            +adc16 x16_r0, $04      ;  |  |- find the object's address
            dex                     ;  |  |
            bne -                   ;  | /
        lda #<obj_table             ;  | \
        clc                         ;  |  |
        adc x16_r0_l                ;  |  |- load the object address into
        sta x16_r0_l                ;  |  |  x16_r0
        lda #>obj_table             ;  |  |
        adc x16_r0_h                ;  |  |
        sta x16_r0_h                ;  | /
        jsr .chor_next_byte         ;  | \
        sta (x16_r0_l)              ;  |  |- configure the object
        +inc16 x16_r0               ;  |  |
        jsr .chor_next_byte         ;  |  |
        sta (x16_r0_l)              ;  | /
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_COA                ; \
    bne +                           ;  |- CONFIGURE OBJECT ON A ( offset, type, param )
        stz x16_r0_l                ;  |
        stz x16_r0_h                ;  |
        jsr .chor_next_byte         ;  |
        clc                         ;  |
        adc choregraphy_reg_a       ;  |
        bra .op_coj_entry           ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_CMO                ; \
    bne +                           ;  |- CONFIGURE MULTIPLE OBJECTS ( from, count, type, param )
        stz x16_r0_l                ;  |
        stz x16_r0_h                ;  |
        jsr .chor_next_byte         ;  | \
        and #$7F                    ;  |  | )- limit to 127 first
        tax                         ;  |  |
        -   clc                     ;  |  |
            +adc16 x16_r0, $04      ;  |  |- find the first object address
            dex                     ;  |  |
            bne -                   ;  | /
        jsr .chor_next_byte         ;  | \_ load count in Y
        tay                         ;  | /
        lda #<obj_table             ;  | \
        clc                         ;  |  |
        adc x16_r0_l                ;  |  |- load the object address into
        sta x16_r0_l                ;  |  |  x16_r0
        lda #>obj_table             ;  |  |
        adc x16_r0_h                ;  |  |
        sta x16_r0_h                ;  | /
        jsr .chor_next_byte         ;  | \
        sta x16_r1_l                ;  |  |- load configuration into x16_r1
        jsr .chor_next_byte         ;  |  |
        sta x16_r1_h                ;  | /
-           lda x16_r1_l            ;  | \  \
            sta (x16_r0_l)          ;  |  |  |- configure the object
            +inc16 x16_r0           ;  |  |  |
            lda x16_r1_h            ;  |  |  |
            sta (x16_r0_l)          ;  |  | /
            clc                     ;  |  |
            +adc16 x16_r0, $03      ;  |  |- loop through every objects
            dey                     ;  |  |
            bne -                   ;  | /
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_SCO                ; \
    bne +                           ;  |- SCORE POINTS ( high_part, middle_part, low_part )
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        jsr add_to_score            ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_SOT                ; \
    bne +                           ;  |- SET SCORE OVER TIME ( score )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        lda difficulty              ;  |
        cmp #DIFFICULTY_EASY        ;  | \_ check if difficulty = easy
        beq .op_sot_easy            ;  | /
        cmp #DIFFICULTY_HARD        ;  | \_ check if difficulty = normal
        bne .op_sot_normal          ;  | /
        txa                         ;  | \
        asl                         ;  |  |- handle hard mode (score x2)
        bcc .op_sot_store           ;  |  |
        lda #$FF                    ;  |  | \_ max 255
        bra .op_sot_store           ;  | /  /
    .op_sot_normal:                 ;  | \_ handle normal mode (score x1)
        txa                         ;  | /
    .op_sot_store:                  ;  | \
        sta score_over_time         ;  |  |- store score_over_time
        bra .op_sot_end             ;  | /
    .op_sot_easy:                   ;  | \_ handle easy mode (score x0)
        stz score_over_time         ;  | /
        .op_sot_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_LIF                ; \
    bne +                           ;  |- GIVE A LIFE ()
        jsr inc_lives               ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_PNC                ; \
    bne +                           ;  |- GIVE A PANIC ()
        jsr inc_panics              ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JMP                ; \
    bne +                           ;  |- JUMP ( addr_l, addr_r )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JAZ                ; \
    bne +                           ;  |- JUMP WHEN REG A IS ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_a       ;  |
        bne .op_jaz_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jaz_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JAN                ; \
    bne +                           ;  |- JUMP WHEN REG A IS NOT ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_a       ;  |
        beq .op_jan_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jan_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JBZ                ; \
    bne +                           ;  |- JUMP WHEN REG B IS ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_b       ;  |
        bne .op_jbz_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jbz_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JBN                ; \
    bne +                           ;  |- JUMP WHEN REG B IS NOT ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_b       ;  |
        beq .op_jbn_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jbn_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JCZ                ; \
    bne +                           ;  |- JUMP WHEN REG C IS ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_c       ;  |
        bne .op_jbz_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jcz_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JCN                ; \
    bne +                           ;  |- JUMP WHEN REG C IS NOT ZERO ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        ldy choregraphy_reg_c       ;  |
        beq .op_jbn_end             ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jcn_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JRN                ; \
    bne +                           ;  |- JUMP RANDOMLY ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        pha                         ;  |
        jsr rng                     ;  |
        cmp #$00                    ;  |
        bmi .op_jrn_other           ;  |
        pla                         ;  |
        sta choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        jmp .op_jrn_end             ;  |
        .op_jrn_other:              ;  |
        pla                         ;  |
        .op_jrn_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JEM                ; \
    bne +                           ;  |- JUMP IF EASY MODE ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        lda difficulty              ;  |
        cmp #DIFFICULTY_EASY        ;  |
        bne .op_jem_end             ;  |
        sty choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jem_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JNE                ; \
    bne +                           ;  |- JUMP IF NOT EASY ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        lda difficulty              ;  |
        cmp #DIFFICULTY_EASY        ;  |
        beq .op_jne_end             ;  |
        sty choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jne_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JNH                ; \
    bne +                           ;  |- JUMP IF NOT HARD MODE ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        lda difficulty              ;  |
        cmp #DIFFICULTY_HARD        ;  |
        beq .op_jnh_end             ;  |
        sty choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jnh_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_JHM                ; \
    bne +                           ;  |- JUMP IF HARD MODE ( addr_l addr_h )
        jsr .chor_next_byte         ;  |
        tax                         ;  |
        jsr .chor_next_byte         ;  |
        tay                         ;  |
        lda difficulty              ;  |
        cmp #DIFFICULTY_HARD        ;  |
        bne .op_jhm_end             ;  |
        sty choregraphy_pc_h        ;  |
        stx choregraphy_pc_l        ;  |
        .op_jhm_end:                ;  |
    jmp .chor_end                   ; /
+
    cmp #CHOR_OP_EXC                ; \
    bne +                           ;  |- EXECUTE CODE (address_l, address_y)
        jsr .chor_next_byte         ;  |
        sta x16_r0_l                ;  | 
        jsr .chor_next_byte         ;  |
        sta x16_r0_h                ;  |
        jsr x16_r0                  ;  | )- TODO: FIX THIS
    jmp .chor_end                   ; /
+
    jmp .chor_end

; ##########################
.chor_set_pos:
    lda choregraphy_pos_x
    sta r_obj_x
    lda choregraphy_pos_y
    sta r_obj_y
    rts
; ##########################
.chor_next_byte:
    lda (choregraphy_pc)
    +inc16 choregraphy_pc
    eor #$00               ; )- this line will recall the cpu status flag
    rts
; ##########################

.chor_end: