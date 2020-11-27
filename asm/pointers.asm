// ********************************************************
// * Patch Introduction Scripts                           *
// ********************************************************
print "[+] Patching Intro Scripts..."
origin $00004F44
    dl patch_intro_script_text_1
origin $000051F4
    dl patch_intro_script_text_2
origin $000052B4
    dl patch_intro_script_text_3
origin $00005452
    dl patch_intro_script_text_4
print "DONE!\n"





// ********************************************************
// * Patch Ending Scripts                                 *
// ********************************************************
print "[+] Patching Ending Scripts..."
origin $00006C02
     dl patch_end_script_text_1
origin $00006C14
     dl patch_end_script_text_2
origin $00006E44
     dl patch_end_script_text_3
origin $00007072
     dl patch_end_script_text_4
print "DONE!\n"

// ********************************************************
// * Patch Credits                                        *
// ********************************************************
print "[+] Patching Credits..."
origin $00008102
    dl credits_congratulation_1
    dl credits_congratulation_2
    dl credits_congratulation_3
origin $00008188
    jmp patch_credits_boss_name
origin $00008340
    jmp patch_credits_developers
print "DONE!\n"


// ********************************************************
// * Patch Graphics loading pointer table                 *
// ********************************************************
print "[+] Patching default GFX Table..."
origin $00002746
    jmp patch_gfx_table
print "DONE!\n"





// ********************************************************
// * Patch Title Screen subtitle "Bloodlines" graphics    *
// ********************************************************
origin $00003708
print "[+] Patching Bloodlines Subtitle GFX..."
    jsr patch_bloodlines
print "DONE!\n"





// ********************************************************
// * Patch Title Screen menu text                         *
// ********************************************************
print "[+] Patching Menu Text..."
origin $0000B4A0
    dl patch_menu_pressstartbutton_text
    dl $0000CA86                         // POS
    dw $1B                               // STRING SIZE    
origin $0000B3FC
    dl patch_menu_konami_text
    dl $0000CC86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B436
    dl patch_menu_konami_text
    dl $0000CC86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B406
    dl patch_menu_copyright_text
    dl $0000CD06                         // POS
    dw $1B                               // STRING SIZE
origin $0000B440
    dl patch_menu_copyright_text
    dl $0000CD06                         // POS
    dw $1B                               // STRING SIZE
origin $0000B418
    dl patch_menu_1Pstart_text
    dl $0000C918                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4BE
    dl patch_menu_1Pstart_text
    dl $0000C918                         // POS
    dw $1B                               // STRING SIZE
origin $0000B422
    dl patch_menu_password_text
    dl $0000CA18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4DC
    dl patch_menu_password_text
    dl $0000CA18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B42C
    dl patch_menu_options_text
    dl $0000CB18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4FA
    dl patch_menu_options_text
    dl $0000CB18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B452
    dl patch_menu_clear_text
    dl $0000C918                         // POS
    dw $1B                               // STRING SIZE
origin $0000B45C
    dl patch_menu_clear_text
    dl $0000CA18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B466
    dl patch_menu_clear_text
    dl $0000CC86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B470
    dl patch_menu_clear_text
    dl $0000CD06                         // POS
    dw $1B                               // STRING SIZE
origin $0000B47A
    dl patch_menu_clear_text
    dl $0000CB18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B484
    dl patch_menu_clear_text
    dl $0000CC86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B48E
    dl patch_menu_clear_text
    dl $0000CD06                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4AC
    dl patch_menu_clear_text
    dl $0000CA86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4CA
    dl patch_menu_clear_text
    dl $0000C918                         // POS
    dw $1B                               // STRING SIZE
origin $0000B4E8
    dl patch_menu_clear_text
    dl $0000CA18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B506
    dl patch_menu_clear_text
    dl $0000CB18                         // POS
    dw $1B                               // STRING SIZE
origin $0000B524
    dl patch_menu_clear_text
    dl $0000C696                         // POS
    dw $1B                               // STRING SIZE
origin $0000B612
    dl patch_menu_clear_text
    dl $0000C818                         // POS
    dw $1B                               // STRING SIZE
origin $0000B630
    dl patch_menu_clear_text
    dl $0000C918                         // POS
    dw $1B                               // STRING SIZE
origin $0000B64E
    dl patch_menu_clear_text
    dl $0000C818                         // POS
    dw $1B                               // STRING SIZE
origin $0000B832
    dl patch_menu_clear_text
    dl $0000CC86                         // POS
    dw $1B                               // STRING SIZE
origin $0000B83C
    dl patch_menu_clear_text
    dl $0000CD10                         // POS
    dw $1B                               // STRING SIZE
print "DONE!\n"

// ********************************************************
// * Patch Options Screen menu text                       *
// ********************************************************
origin $370E
    jmp patch_menu_inside_options

origin $B872
    dw $000C
    dl patch_menu_nextstage
    
origin $B708
    dw $BA8E
    dw $0000
    dw $F326
    dw $0007
origin $B71A
    dw patch_menu_options_text_normal
origin $B72C
    dw patch_menu_options_text_expert
origin $B73E
    dw patch_menu_options_text_lives_1
origin $B750
    dw patch_menu_options_text_lives_2
origin $B762
    dw patch_menu_options_text_lives_3
origin $B774
    dw patch_menu_options_text_lives_4
origin $B786
    dw patch_menu_options_text_lives_5
origin $B798
    dw patch_menu_options_text_lives_9
origin $B7F4
    dw patch_menu_options_text_display
    dw $0000
    dw $FB2E
    dw $0003
origin $B806
    dw patch_menu_options_text_skip
    dw $0000
    dw $FB2E
    dw $0003



// ********************************************************
// * Patch biography text on Select Character Screen      *
// ********************************************************
origin $3B36
    jmp patch_characters_bio







// ********************************************************
// * Patch Stage Call Screen                              *
// ********************************************************
print "[+] Patching Stage Call Screen..."
origin $00005F06
    jsr patch_stage_call
print "DONE!\n"







// ********************************************************
// * Patch Ingame Messages                                *
// ********************************************************
origin $0003E60C
    jsr load_new_sprite_ingame_msg
origin $0003E3C0
    lea (sprite_ingame_msg_lifebonus).l,a6
origin $0003E400
    lea (sprite_ingame_msg_jewelbonus).l,a6
origin $0003E369
    db  $CD                             // BONUS VALUE COLUMN
origin $0003E385
    db  $CD                             // BONUS VALUE COLUMN

// FONT MAP
// origin $6DD7E
//     dl  $FFF90001
//     dl  $00580000                           //T
//     dw  $FFFD