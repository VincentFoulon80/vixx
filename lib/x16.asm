!cpu 65c02
; kernal functions
; === C64 ==========================================================
; Channel I/O
CHROUT  = $FFD2     ; write character on screen at cursor position
CHRIN   = $FFCF     ; get character
SETLFS  = $FFBA     ; set up a logical file
SETNAM  = $FFBD     ; set a file name
LOAD    = $FFD5     ; loads a file based on SETNAM
SAVE    = $FFD8     ; save a file from memory
OPEN    = $FFC0     ; open a logical file
CLOSE   = $FFC3     ; close a logical file
CHKIN   = $FFC6     ; open a channel for input
CHKOUT  = $FFC9     ; set channel for character output
SETMSG  = $FF90     ; set verbosity
READST  = $FFB7     ; return status byte
CLRCHN  = $FFCC     ; restore character I/O to screen/keyboard
CLALL   = $FFE7     ; close all channels
; Commodore Peripheral Bus
TALK    = $FFB4     ; send TALK command
LISTEN  = $FFB1     ; send LISTEN command
UNLSN   = $FFAE     ; send UNLISTEN command
UNTLK   = $FFBA     ; send UNTALK command
IECOUT  = $FFA8     ; send byte to serial bus
IECIN   = $FFA5     ; read byte from serial bus
SETTMO  = $FFA2     ; set timeout
TKSA    = $FF96     ; send TALK secondary address
SECOND  = $FF93     ; send LISTEN secondary address
; Memory
MEMBOT  = $FF9C     ; read/write address of start of usable RAM
MEMTOP  = $FF99     ; read/write address of end of usable RAM
; Time
RDTIM   = $FFDE     ; read system clock
SETTIM  = $FFDB     ; write system clock
UDTIM   = $FFEA     ; advance clock
; Other
STOP    = $FFE1     ; test for STOP key
GETIN   = $FFE4     ; get character from keyboard
SCREEN  = $FFED     ; get the screen resolution
PLOT    = $FFF0     ; read/write cursor position
IOBASE  = $FFF3     ; return start of I/O area
; === C128 =========================================================
CLOSE_ALL=$FF4A     ; close all files on a device
LKUPLA  = $FF8D     ; search tables for given LA
LKUPSA  = $FF8A     ; search tables for given SA
DLCHR   = $FF62     ; activate a text mode font in the video hardware (not yet implemented)
PFKEY   = $FF65     ; program a function key (not yet implemented)
FETCH   = $FF74     ; LDA (fetvec),Y from any bank (fetvec = $03AF)
STASH   = $FF77     ; STA (stavec),Y to any bank (not yet implemented)
CMPARE  = $FF7A     ; CMP (cmpvec),Y to any bank (not yet implemented)
PRIMM   = $FF7D     ; print string following the caller's code
; === X16 ==========================================================
; Note : usage of a "16-bit" ABI using 16 virtual registers of 16-bit each
; r0 -> r15 uses ZP locations from $02 to $21
; Lower end first, Higher end last, example r0 => L=$02 H=$03
; Clock
clock_set_date_time = $FF4D ; set date and time
clock_get_date_time = $FF50 ; get date and time
; Mouse
mouse_config        = $FF68 ; configure mouse pointer
mouse_scan          = $FF71 ; query mouse
mouse_get           = $FF6B ; get state of mouse
; Joystick
joystick_scan       = $FF53 ; query joysticks
joystick_mask_right = %00000001
joystick_mask_left  = %00000010
joystick_mask_down  = %00000100
joystick_mask_up    = %00001000
joystick_mask_start = %00010000
joystick_mask_select= %00100000
joystick_mask_Y     = %01000000
joystick_mask_nes_B = %01000000
joystick_mask_B     = %10000000
joystick_mask_nes_A = %10000000
joystick_mask_type  = %00001111
joystick_mask_R     = %00010000
joystick_mask_L     = %00100000
joystick_mask_X     = %01000000
joystick_mask_A     = %10000000
joystick_get        = $FF56 ; get state of one joystick, pressed button = corresponding bit is zero
; Sprites
sprite_set_image    = $FEF0 ; set the image of a sprite
sprite_set_position = $FEF3 ; set the position of a sprite
; Framebuffer
FB_init             = $FEF6 ; enable graphics mode
FB_get_info         = $FEF9 ; get screen size and color depth
FB_set_palette      = $FEFC ; set (parts of) the palette
FB_cursor_position  = $FEFF ; position the direct-access cursor
FB_cursor_next_line = $FF02 ; move direct-access cursor to next line
FB_get_pixel        = $FF05 ; read one pixel, update cursor
FB_get_pixels       = $FF08 ; copy pixels into RAM, update cursor
FB_set_pixel        = $FF0B ; set one pixel_ update cursor
FB_set_pixels       = $FF0E ; copy pixels from RAM, update cursor
FB_set_8_pixels     = $FF11 ; set 8 pixels from bit mask (transparent), update cursor
FB_set_8_pixels_opaque=$FF14; set 8 pixels from bit mask (opaque), update cursor
FB_fill_pixels      = $FF17 ; fill pixels with constant color, update cursor
FB_filter_pixels    = $FF1A ; apply transform to pixels, update cursor
FB_move_pixels      = $FF1D ; copy horizontally consecutive pixels to a different position
; Graphics
GRAPH_init          = $FF20 ; initialize graphics
GRAPH_clear         = $FF23 ; clear screen
GRAPH_set_window    = $FF26 ; set clipping region
GRAPH_set_colors    = $FF29 ; set stroke, fill and background colors
GRAPH_draw_line     = $FF2C ; draw a line
GRAPH_draw_rect     = $FF2F ; draw a rectangle (optionally filled)
GRAPH_move_rect     = $FF32 ; move pixels
GRAPH_draw_oval     = $FF35 ; draw an oval or circle
GRAPH_draw_image    = $FF38 ; draw a rectangular image
GRAPH_set_font      = $FF3B ; set the current font
GRAPH_get_char_size = $FF3E ; get size and baseline of a character
GRAPH_put_char      = $FF41 ; print a character
; Console
console_init        = $FEDB ; initialize console mode
console_put_char    = $FEDE ; print character to console
console_put_image   = $FED8 ; draw image as if it was a character
console_get_char    = $FEE1 ; get character from console
console_set_paging_message = $FED5 ; set paging message or disable paging
; Other
memory_fill         = $FEE4 ; fill memory region with a byte value
memory_copy         = $FEE7 ; copy memory region
memory_crc          = $FEEA ; calculate CRC16 of memory region
memory_decompress   = $FEED ; decompress LZSA2 block
entropy_get         = $FECF ; get 24 random bits
monitor             = $FF44 ; enter machine language monitor
enter_basic         = $FF47 ; enter BASIC
screen_set_mode     = $FF5F ; set screen mode
screen_set_charset  = $FF62 ; activate 8x8 text mode charset
; === end of kernal fn =============================================

; PETSCII SPECIAL CHARACTERS
PET_NULL        = $00
PET_COLOR_SWAP  = $01
PET_STOP        = $03
PET_UNDERLINE   = $04
PET_COLOR_WHITE = $05
PET_BOLD        = $06
PET_BELL        = $07
PET_BACKSPACE   = $08
PET_TAB         = $09
PET_LF          = $0A
PET_ITALIC      = $0B
PET_OUTLINE     = $0C
PET_REGULAR_RTN = $0D
PET_LOWERCASE   = $0E
PET_ISO_CHRSET_Y= $0F
PET_F9          = $10
PET_CURSOR_DOWN = $11
PET_REVERSE     = $12
PET_HOME        = $13
PET_DEL         = $14
PET_F10         = $15
PET_F11         = $16
PET_F12         = $17
PET_SHIFT_TAB   = $18
PET_COLOR_RED   = $1C
PET_CURSOR_RIGHT= $1D
PET_COLOR_GREEN = $1E
PET_COLOR_BLUE  = $1F
PET_COLOR_ORANGE= $81
PET_RUN         = $83
PET_HELP        = $84
PET_F1          = $85
PET_F3          = $86
PET_F5          = $87
PET_F7          = $88
PET_F2          = $89
PET_F4          = $8A
PET_F6          = $8B
PET_F8          = $9C
PET_SHIFTED_RTN = $8D
PET_UPPERCASE   = $8E
PET_ISO_CHRSET_N= $8F
PET_COLOR_BLACK = $90
PET_CURSOR_UP   = $91
PET_CLEAR_ALL   = $92
PET_CLEAR       = $93
PET_INSERT      = $94
PET_COLOR_BROWN = $95
PET_COLOR_LRED  = $96
PET_COLOR_DGRAY = $97
PET_COLOR_GRAY  = $98
PET_COLOR_LGREEN= $99
PET_COLOR_LBLUE = $9A
PET_COLOR_LGRAY = $9B
PET_COLOR_PURPLE= $9C
PET_CURSOR_LEFT = $9D
PET_COLOR_YELLOW= $9E
PET_COLOR_CYAN  = $9F


; hardware addresses
x16_r0 = $0002
x16_r0_l = $02
x16_r0_h = $03
x16_r1 = $0004
x16_r1_l = $04
x16_r1_h = $05
x16_r2 = $0006
x16_r2_l = $06
x16_r2_h = $07
x16_r3 = $0008
x16_r3_l = $08
x16_r3_h = $09
x16_r4 = $000A
x16_r4_l = $0A
x16_r4_h = $0B
x16_r5 = $000C
x16_r5_l = $0C
x16_r5_h = $0D
x16_r6 = $000E
x16_r6_l = $0E
x16_r6_h = $0F
x16_r7 = $0010
x16_r7_l = $10
x16_r7_h = $11
x16_r8 = $0012
x16_r8_l = $12
x16_r8_h = $13
x16_r9 = $0014
x16_r9_l = $14
x16_r9_h = $15
x16_r10 = $0016
x16_r10_l = $16
x16_r10_h = $17
x16_r11 = $0018
x16_r11_l = $18
x16_r11_h = $19
x16_r12 = $001A
x16_r12_l = $1A
x16_r12_h = $1B
x16_r13 = $001C
x16_r13_l = $1C
x16_r13_h = $1D
x16_r14 = $001E
x16_r14_l = $1E
x16_r14_h = $1F
x16_r15 = $0020
x16_r15_l = $20
x16_r15_h = $21
irq_handler = $0314
VIA1_PB = $9F60
VIA1_PA = $9F61


; registers
ROM_BANK = VIA1_PB
RAM_BANK = VIA1_PA


; macros

; BASIC startup command
; uses bytes $801 to $80C to setup a simple command that runs code starting at $080D
!macro basic_startup {
*= $801
    ; !byte $01,$08 ; prg starting location
    !byte $0b,$08 ; basic next command address
    !byte $01,$00 ; basic line number
    !byte $9e,'2','0','6','1' ; SYS 2061 ($80D)
    !byte $00,$00,$00 ; empty BASIC command
}
