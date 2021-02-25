!ifndef is_main !eof

SWP = PET_COLOR_SWAP



file_save_len = 11
file_save_w !pet "@:vixx.sv,s,w"
file_save_r !pet "vixx.sv,s,r"

str_white_on_black  !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE, PET_NULL
str_color_score     !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_YELLOW, PET_NULL
chr_live    !pet "@"
chr_panic   !pet "!"
chr_volume  !pet $A2


; #   # ##### #   # #   #
; #   #   #    # #   # #
; #   #   #     #     #
;  # #    #    # #   # #
;   #   ##### #   # #   #

str_title_0:
!pet PET_COLOR_BLACK, SWP, PET_COLOR_LGREEN
!pet "   ", SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,     SWP, $E9, "  ", SWP, $E9,     SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,     PET_COLOR_LRED, SWP, $E9, SWP, $E9, "  ", PET_COLOR_RED, SWP, $E9, " ", SWP, $E9
!pet PET_NULL
str_title_1:
!pet PET_COLOR_BLACK, SWP, PET_COLOR_LGREEN
!pet "  ", SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,     " ", SWP, $E9, SWP, $E9,     "  ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9,     PET_COLOR_LRED, "  ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9, PET_COLOR_RED, SWP, $E9, SWP, $E9
!pet PET_NULL
str_title_2:
!pet PET_COLOR_BLACK, SWP, PET_COLOR_LGREEN
!pet " ", SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,     " ", SWP, $E9, SWP, $E9,     "   ", SWP, $E9, SWP, $E9," ",     PET_COLOR_LRED, "   ", SWP, $E9, PET_COLOR_RED, SWP, $E9, PET_COLOR_BLACK, SWP, $E9," ", SWP, $E9, SWP, $E9
!pet PET_NULL  
str_title_3:
!pet PET_COLOR_BLACK, SWP, PET_COLOR_LGREEN
!pet " ", SWP, $E9, SWP, $E9, SWP, $E9, SWP, $E9, " ",     " ", SWP, $E9, SWP, $E9,     "  ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9,     PET_COLOR_LRED, "  ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9, PET_COLOR_RED, SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9, SWP, $E9
!pet PET_NULL  
str_title_4:
!pet PET_COLOR_BLACK, SWP, PET_COLOR_LGREEN
!pet " ", SWP, $E9, SWP, $E9, "  ",     SWP, $E9, "  ", SWP, $E9,     SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,     PET_COLOR_LRED, SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9, PET_COLOR_RED, " ", SWP, $E9, " ", SWP, $E9
!pet PET_NULL  

; #   #  ##   #####
;  # #    #   #
;   #     #   #####
;  # #    #   #   #
; #   # ##### #####

; str_title_5:
; !pet PET_COLOR_BLACK, SWP, PET_COLOR_LRED
; !pet "    ", SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,  SWP, $E9, " ", SWP, $E9,    " ", SWP, $E9, "  ", PET_COLOR_RED, SWP, $E9, PET_COLOR_BLACK, SWP, $E9,SWP, $E9,SWP, $E9
; !pet PET_NULL
; str_title_6:
; !pet PET_COLOR_BLACK, SWP, PET_COLOR_LRED
; !pet "    ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9,         "  ", SWP, $E9, SWP, $E9,   " ", SWP, $E9, SWP, $E9, PET_COLOR_RED, SWP, $E9, " ", SWP, $E9, " ", SWP, $E9, SWP, $E9
; !pet PET_NULL
; str_title_7:
; !pet PET_COLOR_BLACK, SWP, PET_COLOR_LRED
; !pet "    ", SWP, $E9, SWP, $E9,                            "   ", SWP, $E9, SWP, $E9,  " ", SWP, $E9, "  ", SWP, $E9, PET_COLOR_RED, " ", SWP, $E9, SWP, $E9, " ", SWP, $E9, SWP, $E9
; !pet PET_NULL  
; str_title_8:
; !pet PET_COLOR_BLACK, SWP, PET_COLOR_LRED
; !pet "  ", SWP, $E9, SWP, $E9,SWP, $E9, SWP, $E9,           "  ", SWP, $E9, SWP, $E9,   " ", SWP, $E9, SWP, $E9, SWP, $E9, SWP, $E9, PET_COLOR_RED, SWP, $E9, SWP, $E9, SWP, $E9, " ", SWP, $E9
; !pet PET_NULL  
; str_title_9:
; !pet PET_COLOR_BLACK, SWP, PET_COLOR_LRED
; !pet SWP, $E9, SWP, $E9, "  ", SWP, $E9, SWP, $E9,          SWP, $E9, "  ", SWP, $E9,   SWP, $E9, "  ", PET_COLOR_RED, SWP, $E9, PET_COLOR_BLACK, SWP, $E9, SWP, $E9, " ", SWP, $E9, "  ", SWP, $E9, SWP, $E9
; !pet PET_NULL  

str_emulator_msg !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE
                 !pet "  emulator detected", PET_REGULAR_RTN, PET_REGULAR_RTN
                 !pet " to save your hi. score, please attach", PET_REGULAR_RTN
                 !pet " an sdcard with the '-sdcard' parameter", PET_REGULAR_RTN, PET_REGULAR_RTN
                 !pet " this message also has the objective", PET_REGULAR_RTN
                 !pet " of fixing joysticks in the emulator", PET_REGULAR_RTN, PET_REGULAR_RTN, PET_REGULAR_RTN
                 !pet "  press enter"
                 !pet PET_COLOR_BLACK,PET_NULL
str_press_start  !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE,"press start",PET_COLOR_BLACK,PET_NULL
str_volume_ctrl  !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE,"volume (u/d)",PET_COLOR_BLACK,PET_NULL

str_paused      !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"paused",PET_COLOR_BLACK,PET_NULL
str_paused_clr  !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"      ",PET_COLOR_BLACK,PET_NULL
str_game_over   !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE,"game over",PET_COLOR_BLACK,PET_NULL
str_new_hiscore !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_YELLOW,"new high score!",PET_COLOR_BLACK,PET_NULL

str_ui_game     !pet PET_COLOR_BLACK, PET_COLOR_SWAP,                "                           ", PET_NULL
str_ui_volume   !pet PET_COLOR_BLACK, PET_COLOR_SWAP,PET_COLOR_WHITE,"        ",$AC,$A4,$A4,$A4,$A4,$A4,$A4,$A4,$A4,$BB,"         ", PET_COLOR_BLACK, PET_NULL


str_ui_full_row         !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK,"                                        ", PET_REGULAR_RTN, PET_NULL
str_ui_game_row         !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK,"            ", PET_REGULAR_RTN, PET_NULL
str_ui_empty_slot_row   !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_YELLOW,"          ",PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_REGULAR_RTN, PET_NULL

str_ui_empty_slot   !pet PET_COLOR_DGRAY, PET_COLOR_SWAP,PET_COLOR_YELLOW,"          ", PET_NULL
str_ui_hiscore_lbl  !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"hi. score:", PET_NULL
str_ui_score_lbl    !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"  score:  ", PET_NULL
str_ui_lives_lbl    !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"  lives:  ", PET_NULL
str_ui_panics_lbl   !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE," panics:  ", PET_NULL


; LVL 1 STRINGS

lvl1_str_warning           !pet "warning", PET_NULL
lvl1_str_clr_warning       !pet "       ", PET_NULL
lvl1_str_clr_ending        !pet "               ", PET_NULL

; LVL 2 STRINGS

lvl2_str_bank_switched     !pet "switched bank",PET_NULL
lvl2_str_clr_bank_switched !pet "             ",PET_NULL