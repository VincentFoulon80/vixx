!ifndef is_main {
    !src "../../lib/x16.asm"
    *= $801
}
file_hiscore_len = 11
file_hiscore_w !pet "@:bhellsc,s,w"
file_hiscore_r !pet "bhellsc,s,r"

str_white_on_black !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE
str_color_score !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_YELLOW, PET_NULL
chr_live !pet "S"

str_press_enter !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE,"press enter",PET_COLOR_BLACK,PET_NULL
str_game_over !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_WHITE,"game over",PET_COLOR_BLACK,PET_NULL
str_new_hiscore !pet PET_COLOR_BLACK, PET_COLOR_SWAP, PET_COLOR_YELLOW,"new high score!",PET_COLOR_BLACK,PET_NULL


str_ui_full_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK,"                                        ", PET_REGULAR_RTN, PET_NULL
str_ui_game_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK,"            ", PET_REGULAR_RTN, PET_NULL

str_ui_empty_slot !pet PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_YELLOW,"          ", PET_NULL

str_ui_hiscore_lbl_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"hi. score:",PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_REGULAR_RTN, PET_NULL
str_ui_score_lbl_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"  score:  ",PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_REGULAR_RTN, PET_NULL
str_ui_lives_lbl_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_WHITE,"  lives:  ",PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_REGULAR_RTN, PET_NULL
str_ui_empty_slot_row !pet PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ",PET_COLOR_BLACK, PET_COLOR_SWAP, "                           ", PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_COLOR_DGRAY, PET_COLOR_SWAP, PET_COLOR_YELLOW,"          ",PET_COLOR_GRAY, PET_COLOR_SWAP, PET_COLOR_BLACK," ", PET_REGULAR_RTN, PET_NULL