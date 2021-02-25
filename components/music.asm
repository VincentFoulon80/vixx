!ifndef is_main !eof

N_NOP = $00 ; do nothing
N_C0  = $01
N_CS0 = $02
N_D0  = $03
N_DS0 = $04
N_E0  = $05
N_F0  = $06
N_FS0 = $07
N_G0  = $08
N_GS0 = $09
N_A0  = $0A
N_AS0 = $0B
N_B0  = $0C
N_C1  = $0D
N_CS1 = $0E
N_D1  = $0F
N_DS1 = $10
N_E1  = $11
N_F1  = $12
N_FS1 = $13
N_G1  = $14
N_GS1 = $15
N_A1  = $16
N_AS1 = $17
N_B1  = $18
N_C2  = $19
N_CS2 = $1A
N_D2  = $1B
N_DS2 = $1C
N_E2  = $1D
N_F2  = $1E
N_FS2 = $1F
N_G2  = $20
N_GS2 = $21
N_A2  = $22
N_AS2 = $23
N_B2  = $24
N_C3  = $25
N_CS3 = $26
N_D3  = $27
N_DS3 = $28
N_E3  = $29
N_F3  = $2A
N_FS3 = $2B
N_G3  = $2C
N_GS3 = $2D
N_A3  = $2E
N_AS3 = $2F
N_B3  = $30
N_C4  = $31
N_CS4 = $32
N_D4  = $33
N_DS4 = $34
N_E4  = $35
N_F4  = $36
N_FS4 = $37
N_G4  = $38
N_GS4 = $39
N_A4  = $3A
N_AS4 = $3B
N_B4  = $3C
N_C5  = $3D
N_CS5 = $3E
N_D5  = $3F
N_DS5 = $40
N_E5  = $41
N_F5  = $42
N_FS5 = $43
N_G5  = $44
N_GS5 = $45
N_A5  = $46
N_AS5 = $47
N_B5  = $48
N_C6  = $49
N_CS6 = $4A
N_D6  = $4B
N_DS6 = $4C
N_E6  = $4D
N_F6  = $4E
N_FS6 = $4F
N_G6  = $50
N_GS6 = $51
N_A6  = $52
N_AS6 = $53
N_B6  = $54
N_C7  = $55
N_CS7 = $56
N_D7  = $57
N_DS7 = $58
N_E7  = $59
N_F7  = $5A
N_FS7 = $5B
N_G7  = $5C
N_GS7 = $5D
N_A7  = $5E
N_AS7 = $5F
N_B7  = $60
N_C8  = $61
N_CS8 = $62
N_D8  = $63
N_DS8 = $64
N_E8  = $65
N_F8  = $66
N_FS8 = $67
N_G8  = $68
N_GS8 = $69
N_A8  = $6A
N_AS8 = $6B
N_B8  = $6C
N_STP = $6D ; stop current note
N_GNP = $6E ; global NOP
N_GSP = $6F ; global STOP

N_JMS = $FA ; Jump to a section
N_RTS = $FB ; Return from a section
N_RTM = $FC ; changes the rythm
N_INS = $FD ; changes the instrument
N_VOI = $FE ; changes the number of voices
N_JMP = $FF ; jumps to another music section


NOTE_NOP= $0000
NOTE_C0 = $002C
NOTE_CS0= $002E
NOTE_D0 = $0031
NOTE_DS0= $0034
NOTE_E0 = $0037
NOTE_F0 = $003B
NOTE_FS0= $003E
NOTE_G0 = $0042
NOTE_GS0= $0046
NOTE_A0 = $004A
NOTE_AS0= $004E
NOTE_B0 = $0053
NOTE_C1 = $0058
NOTE_CS1= $005D
NOTE_D1 = $0063
NOTE_DS1= $0068
NOTE_E1 = $006F
NOTE_F1 = $0075
NOTE_FS1= $007C
NOTE_G1 = $0084
NOTE_GS1= $008B
NOTE_A1 = $0094
NOTE_AS1= $009C
NOTE_B1 = $00A6
NOTE_C2 = $00B0
NOTE_CS2= $00BA
NOTE_D2 = $00C5
NOTE_DS2= $00D1
NOTE_E2 = $00DD
NOTE_F2 = $00EA
NOTE_FS2= $00F8
NOTE_G2 = $0107
NOTE_GS2= $0117
NOTE_A2 = $0127
NOTE_AS2= $0139
NOTE_B2 = $014B
NOTE_C3 = $015F
NOTE_CS3= $0174
NOTE_D3 = $018A
NOTE_DS3= $01A2
NOTE_E3 = $01BA
NOTE_F3 = $01D5
NOTE_FS3= $01F1
NOTE_G3 = $020E
NOTE_GS3= $022D
NOTE_A3 = $024F
NOTE_AS3= $0272
NOTE_B3 = $0297
NOTE_C4 = $02BE
NOTE_CS4= $02E8
NOTE_D4 = $0314
NOTE_DS4= $0343
NOTE_E4 = $0375
NOTE_F4 = $03A9
NOTE_FS4= $03E1
NOTE_G4 = $041C
NOTE_GS4= $045B
NOTE_A4 = $049D
NOTE_AS4= $04E3
NOTE_B4 = $052E
NOTE_C5 = $057D
NOTE_CS5= $05D0
NOTE_D5 = $0629
NOTE_DS5= $0686
NOTE_E5 = $06EA
NOTE_F5 = $0753
NOTE_FS5= $07C2
NOTE_G5 = $0839
NOTE_GS5= $08B6
NOTE_A5 = $093A
NOTE_AS5= $09C7
NOTE_B5 = $0A5C
NOTE_C6 = $0AF9
NOTE_CS6= $0BA0
NOTE_D6 = $0C51
NOTE_DS6= $0D0D
NOTE_E6 = $0DD3
NOTE_F6 = $0EA6
NOTE_FS6= $0F85
NOTE_G6 = $1071
NOTE_GS6= $116B
NOTE_A6 = $1274
NOTE_AS6= $138D
NOTE_B6 = $14B7
NOTE_C7 = $15F2
NOTE_CS7= $1740
NOTE_D7 = $18A2
NOTE_DS7= $1A19
NOTE_E7 = $1BA7
NOTE_F7 = $1D4C
NOTE_FS7= $1F0A
NOTE_G7 = $20E2
NOTE_GS7= $22D7
NOTE_A7 = $24E9
NOTE_AS7= $271B
NOTE_B7 = $296E
NOTE_C8 = $2BE5
NOTE_CS8= $2E81
NOTE_D8 = $3145
NOTE_DS8= $3433
NOTE_E8 = $374D
NOTE_F8 = $3A97
NOTE_FS8= $3E13
NOTE_G8 = $41C4
NOTE_GS8= $45AD
NOTE_A8 = $49D2
NOTE_AS8= $4E36
NOTE_B8 = $52DC





    lda wait_frame              ; \
    and #WFRAME_MUSIC           ;  |- execute the following code
    beq +                       ;  |  only once per frame
    jmp music_end               ;  |
+   lda wait_frame              ;  |
    ora #WFRAME_MUSIC           ;  |
    sta wait_frame              ; /
instrument_start:
    ldy #$07                        ; \
-                                   ;  |
    cpy psg_vo_cnt                  ;  |- clear unused voices
    beq processs_instrument_start   ;  |
    lda #$00                        ;  |
    sta psg_vo_note,y               ;  |
    sta psg_vo_volumeHi,y           ;  |
    sta psg_vo_volumeLo,y           ;  |
    dey                             ;  |
    bne +                           ;  |
    jmp processs_instrument_end     ;  |
+   jmp -                           ; /
processs_instrument_start:
    dey
processs_instrument:
    lda psg_vo_instr,y              ; \
    asl                             ;  |- get instrument index of the 
    asl                             ;  |  current voice in X register
    asl                             ;  |
    tax                             ; /
    lda psg_vo_mode,y
    cmp #$01
    bne +
        ; MODE 0 : UNINITIALIZED
        ; calculate attack delta and delay
        ; delay
        phx
        lda instrument_def + instr_idx_AD_delay,x
        +get_left
        tax
        lda durations,x
        sta psg_vo_delay,y
        
        ; delta
        stz dividend
        plx
        lda instrument_def + instr_idx_vol_max,x
        sta dividend+1
        lda psg_vo_delay,y
        sta divisor
        stz divisor+1

        jsr divide

        lda result
        sta psg_vo_deltaLo,y
        lda result+1
        sta psg_vo_deltaHi,y

        lda #$02
        sta psg_vo_mode,y
        lda #$00
        sta psg_vo_volumeLo,y
        sta psg_vo_volumeHi,y
    jmp processs_instrument_end
+   
    cmp #$02
    bne +
        ; MODE 1 : ATTACK
        clc                     ; \
        lda psg_vo_volumeLo,y   ;  |
        adc psg_vo_deltaLo,y    ;  |- adc16 volume + delta
        sta psg_vo_volumeLo,y   ;  |
        lda psg_vo_volumeHi,y   ;  |
        adc psg_vo_deltaHi,y    ;  |
        sta psg_vo_volumeHi,y   ; /

        lda psg_vo_delay,y
        dec
        bne .instr_attack_end
        ; prepare DECAY
        ; delay
        phx
        lda instrument_def + instr_idx_AD_delay,x
        +get_right
        tax
        lda durations,x
        sta psg_vo_delay,y
        ; delta
        stz dividend
        plx
        sec
        lda instrument_def + instr_idx_vol_max,x
        sta psg_vo_volumeHi,y
        sbc instrument_def + instr_idx_vol_sus,x
        sta dividend+1
        lda psg_vo_delay,y
        sta divisor
        stz divisor+1

        jsr divide

        lda result
        sta psg_vo_deltaLo,y
        lda result+1
        sta psg_vo_deltaHi,y

        lda #$03
        sta psg_vo_mode,y
        lda #$00
        sta psg_vo_volumeLo,y
        jmp processs_instrument_end
    .instr_attack_end:
        sta psg_vo_delay,y
    jmp processs_instrument_end
+
    cmp #$03
    bne +
        ; MODE 2 : DECAY
        sec                     ; \
        lda psg_vo_volumeLo,y   ;  |
        sbc psg_vo_deltaLo,y    ;  |- sbc16 volume + delta
        sta psg_vo_volumeLo,y   ;  |
        lda psg_vo_volumeHi,y   ;  |
        sbc psg_vo_deltaHi,y    ;  |
        sta psg_vo_volumeHi,y   ; /

        lda psg_vo_delay,y
        dec
        bne .instr_decay_end

        ; prepare SUSTAIN
        ; delay
        lda instrument_def + instr_idx_vol_sus,x
        sta psg_vo_volumeHi,y
        lda instrument_def + instr_idx_SR_delay,x
        +get_left
        tax
        lda durations,x
        sta psg_vo_delay,y

        lda #$04
        sta psg_vo_mode,y
        lda #$00
        sta psg_vo_volumeLo,y
        jmp processs_instrument_end
    .instr_decay_end:
        sta psg_vo_delay,y
    jmp processs_instrument_end
+
    cmp #$04
    bne +
        ; MODE 3 : SUSTAIN
        lda psg_vo_delay,y
        beq .prepare_release
        dec
        bne .instr_sustain_end

        .prepare_release:
        ; delay
        phx
        lda instrument_def + instr_idx_SR_delay,x
        +get_right
        tax
        lda durations,x
        sta psg_vo_delay,y

        ; delta
        stz dividend
        plx
        sec
        lda instrument_def + instr_idx_vol_sus,x
        sta dividend+1
        lda psg_vo_delay,y
        sta divisor
        stz divisor+1

        jsr divide

        lda result
        sta psg_vo_deltaLo,y
        lda result+1
        sta psg_vo_deltaHi,y

        lda #$05
        sta psg_vo_mode,y
        lda #$00
        sta psg_vo_volumeLo,y
        jmp processs_instrument_end
    .instr_sustain_end:
        sta psg_vo_delay,y
    jmp processs_instrument_end
+
    cmp #$05
    bne +
        ; MODE 4 : RELEASE
        sec                     ; \
        lda psg_vo_volumeLo,y   ;  |
        sbc psg_vo_deltaLo,y    ;  |- sbc16 volume + delta
        sta psg_vo_volumeLo,y   ;  |
        lda psg_vo_volumeHi,y   ;  |
        sbc psg_vo_deltaHi,y    ;  |
        sta psg_vo_volumeHi,y   ; /

        lda psg_vo_delay,y
        dec
        bne .instr_release_end
        ; END SOUND
        lda #$00
        sta psg_vo_volumeLo,y
        sta psg_vo_volumeHi,y
        sta psg_vo_mode,y
    .instr_release_end:
        sta psg_vo_delay,y
    jmp processs_instrument_end
+
processs_instrument_end:
    dey
    cpy #$FF
    beq instrument_end
    jmp processs_instrument

instrument_end:
    dec composer_delay          ; \
    beq +                       ;  |- handle rhythm
    jmp composer_end            ;  |
+                               ;  |
    lda composer_rythm          ;  |
    sta composer_delay          ; /
composer_start:
    ldy psg_vo_cnt
    jsr .music_next_byte
    ; look for command
    cmp #N_GNP                  ; \
    bne +                       ;  |- GLOBAL NOP ()
        jmp composer_end        ;  |  nop all voices at once
    jmp composer_start          ; /
+
    cmp #N_GSP                  ; \
    bne +                       ;  |- GLOBAL STOP ()
        ldx #$00                ;  |
    -                           ;  |
        lda #$00                ;  |
        sta psg_vo_note,x       ;  |
        lda #$01                ;  |
        sta psg_vo_mode,x       ;  |
        inx                     ;  |
        cpx #$08                ;  |
        bne -                   ;  |
        jmp composer_end        ;  |  nop all voices at once
    jmp composer_start          ; /
+
    cmp #N_INS                  ; \
    bne +                       ;  |- SET INSTRUMENT ( voice, instrument )
        jsr .music_next_byte    ;  |
        tax                     ;  |
        jsr .music_next_byte    ;  |
        sta psg_vo_instr,x      ;  |
    jmp composer_start          ; /
+
    cmp #N_RTM                  ; \
    bne +                       ;  |- SET RHYTHM ( frames_to_wait )
        jsr .music_next_byte    ;  |
        sta composer_rythm      ;  |
        sta composer_delay      ;  |
    jmp composer_start          ; /
+
    cmp #N_JMP                  ; \
    bne +                       ;  |- JUMP ( addr_l, addr_h )
        jsr .music_next_byte    ;  |
        tax                     ;  |
        jsr .music_next_byte    ;  |
        stx composer_pc_l       ;  |
        sta composer_pc_h       ;  |
    jmp composer_start          ; /
+
    cmp #N_JMS                  ; \
    bne +                       ;  |- JUMP TO SECTION (addr_l, addr_h)
        jsr .music_next_byte    ;  |
        tax                     ;  |
        jsr .music_next_byte    ;  |
        tay                     ;  |
        lda composer_pc_l       ;  |
        sta composer_sr_l       ;  |
        lda composer_pc_h       ;  |
        sta composer_sr_h       ;  |
        stx composer_pc_l       ;  |
        sty composer_pc_h       ;  |
    jmp composer_start          ; /
+
    cmp #N_RTS                  ; \
    bne +                       ;  |- RETURN FROM SECTION ()
        lda composer_sr_l       ;  |
        sta composer_pc_l       ;  |
        lda composer_sr_h       ;  |
        sta composer_pc_h       ;  |
    jmp composer_start          ; /
+
    cmp #N_VOI                  ; \
    bne +                       ;  |- SET VOICES ( count )
        jsr .music_next_byte    ;  |
        sta psg_vo_cnt          ;  |
    jmp composer_start          ; /
+
    ; check y > 0
    cpy #$00
    bne +
    jmp composer_end
    ; interpret note for each voice
+   
    ldx #$00
-   
    cmp #$00                    ; \_ ignore NOPs
    beq +                       ; /
    sta psg_vo_note,x           ; \
    lda #$01                    ;  |- set note and activate note
    sta psg_vo_mode,x           ; /
+   dey
    beq composer_end            ; \
    inx                         ;  |- continue to read the stream until
    jsr .music_next_byte        ;  |  all voices has been processed
    jmp -                       ; /

composer_end:
    jmp music_end


; ##########################
.music_next_byte:
    lda (composer_pc)
    +inc16 composer_pc
    eor #$00               ; )- this line will recall the cpu status flag
    rts
; ##########################

; ##########################
music_clear:
    ldy #$08
    lda #$00
-   sta psg_vo_volumeLo,y
    sta psg_vo_volumeHi,y
    sta psg_vo_mode,y
    dey
    bpl -
    rts
; ##########################

; ##########################
divide:
	phx						; save X
    phy

	stz remainder			; preset reminder to 0
	stz remainder+1
    stz result
    stz result
	ldx #16					; repeat for each bit: ...

divloop:
	asl dividend			; dividend lb & hb*2, msb -> Carry
	rol dividend+1	
	rol remainder			; remainder lb & hb * 2 + msb from carry
	rol remainder+1
	lda remainder
	sec
	sbc divisor				; substract divisor to see if it fits in
	tay						; lb result -> Y, for we may need it later
	lda remainder+1
	sbc divisor+1
	bcc +					; if carry=0 then divisor didn't fit in yet

	sta remainder+1			; else save substraction result as new remainder,
	sty remainder	
	inc result				; and INCrement result cause divisor fit in 1 times

+	dex
	bne divloop	

    ply
	plx
	rts
; ##########################

instr_idx_waveform   = $00
instr_idx_AD_delay   = $01
instr_idx_SR_delay   = $02
instr_idx_continuous = $03
instr_idx_vol_max    = $04
instr_idx_vol_sus    = $05
instr_idx_direction  = $06
instr_idx_not_used   = $07

I_LONG_SAW      = $00
I_LONG_PULSE    = $01
I_LONG_TRIANGLE = $02
I_TINY_SAW      = $03
I_TINY_NOISE    = $04
I_TINY_PULSE    = $05
I_SHORT_PULSE   = $06

instrument_def:
    !byte vera_psg_waveform_sawtooth,   $22, $AE, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_pulse,      $22, $AE, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_triangle,   $22, $AE, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_sawtooth,   $22, $51, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_noise,      $22, $05, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_pulse,      $22, $05, 0, 63, 63, vera_psg_left|vera_psg_right, 0
    !byte vera_psg_waveform_pulse,      $22, $81, 0, 63, 63, vera_psg_left|vera_psg_right, 0

durations:
    !byte 0
    !byte 1
    !byte 2
    !byte 3
    !byte 4
    !byte 5
    !byte 7
    !byte 10
    !byte 12
    !byte 15
    !byte 20
    !byte 30
    !byte 40
    !byte 60
    !byte 90
    !byte 120

note_l:
    !byte <NOTE_NOP
    !byte <NOTE_C0 
    !byte <NOTE_CS0
    !byte <NOTE_D0 
    !byte <NOTE_DS0
    !byte <NOTE_E0 
    !byte <NOTE_F0 
    !byte <NOTE_FS0
    !byte <NOTE_G0 
    !byte <NOTE_GS0
    !byte <NOTE_A0 
    !byte <NOTE_AS0
    !byte <NOTE_B0 
    !byte <NOTE_C1 
    !byte <NOTE_CS1
    !byte <NOTE_D1 
    !byte <NOTE_DS1
    !byte <NOTE_E1 
    !byte <NOTE_F1 
    !byte <NOTE_FS1
    !byte <NOTE_G1 
    !byte <NOTE_GS1
    !byte <NOTE_A1 
    !byte <NOTE_AS1
    !byte <NOTE_B1 
    !byte <NOTE_C2 
    !byte <NOTE_CS2
    !byte <NOTE_D2 
    !byte <NOTE_DS2
    !byte <NOTE_E2 
    !byte <NOTE_F2 
    !byte <NOTE_FS2
    !byte <NOTE_G2 
    !byte <NOTE_GS2
    !byte <NOTE_A2 
    !byte <NOTE_AS2
    !byte <NOTE_B2 
    !byte <NOTE_C3 
    !byte <NOTE_CS3
    !byte <NOTE_D3 
    !byte <NOTE_DS3
    !byte <NOTE_E3 
    !byte <NOTE_F3 
    !byte <NOTE_FS3
    !byte <NOTE_G3 
    !byte <NOTE_GS3
    !byte <NOTE_A3 
    !byte <NOTE_AS3
    !byte <NOTE_B3 
    !byte <NOTE_C4 
    !byte <NOTE_CS4
    !byte <NOTE_D4 
    !byte <NOTE_DS4
    !byte <NOTE_E4 
    !byte <NOTE_F4 
    !byte <NOTE_FS4
    !byte <NOTE_G4 
    !byte <NOTE_GS4
    !byte <NOTE_A4 
    !byte <NOTE_AS4
    !byte <NOTE_B4 
    !byte <NOTE_C5 
    !byte <NOTE_CS5
    !byte <NOTE_D5 
    !byte <NOTE_DS5
    !byte <NOTE_E5 
    !byte <NOTE_F5 
    !byte <NOTE_FS5
    !byte <NOTE_G5 
    !byte <NOTE_GS5
    !byte <NOTE_A5 
    !byte <NOTE_AS5
    !byte <NOTE_B5 
    !byte <NOTE_C6 
    !byte <NOTE_CS6
    !byte <NOTE_D6 
    !byte <NOTE_DS6
    !byte <NOTE_E6 
    !byte <NOTE_F6 
    !byte <NOTE_FS6
    !byte <NOTE_G6 
    !byte <NOTE_GS6
    !byte <NOTE_A6 
    !byte <NOTE_AS6
    !byte <NOTE_B6 
    !byte <NOTE_C7 
    !byte <NOTE_CS7
    !byte <NOTE_D7 
    !byte <NOTE_DS7
    !byte <NOTE_E7 
    !byte <NOTE_F7 
    !byte <NOTE_FS7
    !byte <NOTE_G7 
    !byte <NOTE_GS7
    !byte <NOTE_A7 
    !byte <NOTE_AS7
    !byte <NOTE_B7 
    !byte <NOTE_C8 
    !byte <NOTE_CS8
    !byte <NOTE_D8 
    !byte <NOTE_DS8
    !byte <NOTE_E8 
    !byte <NOTE_F8 
    !byte <NOTE_FS8
    !byte <NOTE_G8 
    !byte <NOTE_GS8
    !byte <NOTE_A8 
    !byte <NOTE_AS8
    !byte <NOTE_B8 
    !byte <NOTE_NOP

note_h:
    !byte >NOTE_NOP
    !byte >NOTE_C0 
    !byte >NOTE_CS0
    !byte >NOTE_D0 
    !byte >NOTE_DS0
    !byte >NOTE_E0 
    !byte >NOTE_F0 
    !byte >NOTE_FS0
    !byte >NOTE_G0 
    !byte >NOTE_GS0
    !byte >NOTE_A0 
    !byte >NOTE_AS0
    !byte >NOTE_B0 
    !byte >NOTE_C1 
    !byte >NOTE_CS1
    !byte >NOTE_D1 
    !byte >NOTE_DS1
    !byte >NOTE_E1 
    !byte >NOTE_F1 
    !byte >NOTE_FS1
    !byte >NOTE_G1 
    !byte >NOTE_GS1
    !byte >NOTE_A1 
    !byte >NOTE_AS1
    !byte >NOTE_B1 
    !byte >NOTE_C2 
    !byte >NOTE_CS2
    !byte >NOTE_D2 
    !byte >NOTE_DS2
    !byte >NOTE_E2 
    !byte >NOTE_F2 
    !byte >NOTE_FS2
    !byte >NOTE_G2 
    !byte >NOTE_GS2
    !byte >NOTE_A2 
    !byte >NOTE_AS2
    !byte >NOTE_B2 
    !byte >NOTE_C3 
    !byte >NOTE_CS3
    !byte >NOTE_D3 
    !byte >NOTE_DS3
    !byte >NOTE_E3 
    !byte >NOTE_F3 
    !byte >NOTE_FS3
    !byte >NOTE_G3 
    !byte >NOTE_GS3
    !byte >NOTE_A3 
    !byte >NOTE_AS3
    !byte >NOTE_B3 
    !byte >NOTE_C4 
    !byte >NOTE_CS4
    !byte >NOTE_D4 
    !byte >NOTE_DS4
    !byte >NOTE_E4 
    !byte >NOTE_F4 
    !byte >NOTE_FS4
    !byte >NOTE_G4 
    !byte >NOTE_GS4
    !byte >NOTE_A4 
    !byte >NOTE_AS4
    !byte >NOTE_B4 
    !byte >NOTE_C5 
    !byte >NOTE_CS5
    !byte >NOTE_D5 
    !byte >NOTE_DS5
    !byte >NOTE_E5 
    !byte >NOTE_F5 
    !byte >NOTE_FS5
    !byte >NOTE_G5 
    !byte >NOTE_GS5
    !byte >NOTE_A5 
    !byte >NOTE_AS5
    !byte >NOTE_B5 
    !byte >NOTE_C6 
    !byte >NOTE_CS6
    !byte >NOTE_D6 
    !byte >NOTE_DS6
    !byte >NOTE_E6 
    !byte >NOTE_F6 
    !byte >NOTE_FS6
    !byte >NOTE_G6 
    !byte >NOTE_GS6
    !byte >NOTE_A6 
    !byte >NOTE_AS6
    !byte >NOTE_B6 
    !byte >NOTE_C7 
    !byte >NOTE_CS7
    !byte >NOTE_D7 
    !byte >NOTE_DS7
    !byte >NOTE_E7 
    !byte >NOTE_F7 
    !byte >NOTE_FS7
    !byte >NOTE_G7 
    !byte >NOTE_GS7
    !byte >NOTE_A7 
    !byte >NOTE_AS7
    !byte >NOTE_B7 
    !byte >NOTE_C8 
    !byte >NOTE_CS8
    !byte >NOTE_D8 
    !byte >NOTE_DS8
    !byte >NOTE_E8 
    !byte >NOTE_F8 
    !byte >NOTE_FS8
    !byte >NOTE_G8 
    !byte >NOTE_GS8
    !byte >NOTE_A8 
    !byte >NOTE_AS8
    !byte >NOTE_B8 
    !byte >NOTE_NOP

music_end: