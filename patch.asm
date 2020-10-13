// ********************************************************
// *             [SMD] Castlevania Bloodlines             *
// ********************************************************
// * Patch:  Translation ASM Patch v1.0                   *
// * Author: Hans Bonini (Anime_World)                    *
// ********************************************************
// * Notes:                                               *
// *  -                                                   *
// ********************************************************

arch    md.cpu
endian  msb
output  "castlevania_br.md",create
insert  "castlevania.md"





// ********************************************************
// * DEBUG FLAGS:                                         *
// *                                                      *
// *  - DEBUG_STAGE(INT STAGE_NUM):                       *
// *    Enable Stage Select                               *
// *                                                      *
// *  - DEBUG_SUBSTAGE(INT SUBSTAGE_NUM):                 *
// *    Select Substage: Default 1                        *
// *                                                      *
// *  - DEBUG_INVENCIBILITY(BOOL ENABLE):                 *
// *    Disable Player Collision: Default 0               *
// ********************************************************
define DEBUG(1)
define DEBUG_STAGE(0)
define DEBUG_SUBSTAGE(1)
define DEBUG_INVENCIBILITY(1)





// ********************************************************
// * SEGA GENESIS CONSTANTS:                              *
// *  - VDP_DATA(INT OFFSET):                             *
// *    Default SEGA GENESIS VDP Data Port                *
// *                                                      *
// *  - VDP_CTRL(INT OFFSET):                             *
// *    Default SEGA GENESIS VDP Ctrl Port                *
// *                                                      *
// *  - M68K_RAM(INT OFFSET):                             *
// *    Default SEGA GENESIS RAM Addr                     *
// ********************************************************
define VDP_DATA($00C00000)
define VDP_CTRL($00C00004)
define M68K_RAM($00FF0000)





// ********************************************************
// * GAME CONSTANTS:                                      *
// *  - GFX_FONT_SCORE(INT OFFSET):                       *
// *    Default address of GAME FONT used in SCORE        *
// *                                                      *
// *  - GFX_FONT_DEFAULT(INT OFFSET):                     *
// *    Default address of GAME FONT used in              *
// *    TITLE SCREEN, MENUS, COPYRIGHT                    *
// *                                                      *
// *  - GFX_INGAME_FONT(INT OFFSET):                      *
// *    Default address of GAME FONT used in INGAME       *
// *    messages like "STAGE 1 START"                     *
// *                                                      *
// *  - STAGE_COUNTER(INT OFFSET):                        *
// *    Count number of stages, used to know current      *
// *    stage on Stage Call Screen                        *
// ********************************************************
define GFX_FONT_SCORE($000ACA18)
define GFX_FONT_DEFAULT($000A8336)
define GFX_INGAME_FONT($00073B94)
define STAGE_COUNTER($FF90EC)





// ********************************************************
// * GAME FUNCTIONS:                                      *
// *  - loadCompressedGFXandSaveRegisters(INT OFFSET)     *
// *                                                      *
// *  - loadCompressedGFXandIncrementPointer(INT OFFSET)  *
// *                                                      *
// *  - loadCompressedGFX(INT OFFSET)                     *
// *                                                      *
// *  - drawTilemap(INT OFFSET)                           *
// ********************************************************
define loadCompressedGFXandSaveRegisters($26E4)
define loadCompressedGFXandIncrementPointer($2628)
define loadCompressedGFX($262A)
define drawTilemap($AB7A)





// ********************************************************
// * MACROS:                                              *
// *  - save_registers_to_sp():                           *
// *    Save all register to a7                           *
// *                                                      *
// *  - load_register_from_sp():                          *
// *    Load all saved registers in a7                    *
// *                                                      *
// *  - loadUncompressedGFX(SRC, DEST, TILES):            *
// *    Load specified SRC into VRAM on selected DEST     *
// *                                                      *
// *  - loadUncompressedGFXtoRAM(SRC, TILES):             *
// *    Load specified SRC into RAM                       *
// *                                                      *
// *  - configureText(LINE, COLUMN, SPEED):               *
// *    Configure intro and ending text display           *
// *                                                      *
// *  - gameText(STRING):                                 *
// *    Intro or Ending text string                       *
// *                                                      *
// *  - endText():                                        *
// *    End sequence of text string for Intro or Ending   *
// *                                                      *
// *  - menuText(STRING):                                 *
// *    Title Screen Menus text string                    *
// *                                                      *
// *  - menuOptionsText(STRING):                          *
// *    Options Screen Menus text string                  *
// *                                                      *
// *  - ingameMessage(WIDTH, COLUMN, STRING):             *
// *    Ingame Message like "STAGE CLEAR" text string     *
// *                                                      *
// *  - ingameMessage2(WIDTH, COLUMN, LINE, STRING):      *
// *    Ingame Message like "JEWEL BONUS" text string     *
// *                                                      *
// *  - selectStage(STAGE_ID):                            *
// *    Start the game on defined STAGE ID                *
// *                                                      *
// *  - disablePlayerCollision():                         *
// *    Disable player collision                          *
// ********************************************************
macro save_registers_to_sp() {
    movem.l #$FFFF,-(a7)
}
macro load_register_from_sp() {
    movem.l (a7)+,#$FFFF
}
macro loadUncompressedGFX(SRC, DEST, TOTAL_TILES) {
    save_registers_to_sp()
    move.l  #($40000000+(({DEST}&$3FFF)<<16)+(({DEST}&$C000)>>14)),({VDP_CTRL}).l
    movea.l #({SRC}),a0
    clr.l   d0
    move.l  #(({TOTAL_TILES}/32)-1),d0
-;
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #1
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #2
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #3
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #4
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #5
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #6
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #7
    move.l  (a0)+,({VDP_DATA}).l //; TILE LINE #8
    dbf     d0,-
    load_register_from_sp()
}
macro loadUncompressedGFXtoRAM(SRC, TOTAL_TILES) {
    save_registers_to_sp()
    movea.l d0,a1
    movea.l #({SRC}),a0
    clr.l   d0
    move.l  #(({TOTAL_TILES}/32)-1),d0
-;
    move.l  (a0)+,(a1)+ //; TILE LINE #1
    move.l  (a0)+,(a1)+ //; TILE LINE #2
    move.l  (a0)+,(a1)+ //; TILE LINE #3
    move.l  (a0)+,(a1)+ //; TILE LINE #4
    move.l  (a0)+,(a1)+ //; TILE LINE #5
    move.l  (a0)+,(a1)+ //; TILE LINE #6
    move.l  (a0)+,(a1)+ //; TILE LINE #7
    move.l  (a0)+,(a1)+ //; TILE LINE #8
    dbf     d0,-
    load_register_from_sp()
}
macro configureText(LINE, COLUMN, SPEED) {
    dw {LINE}
    dw {COLUMN}
    dw {SPEED}
}
macro gameText(STRING) {

    map ' ', $55
    map '.', $38
    map ':', $37
    map $2C, $36 // ','
    map '!', $34
    map 'A', $1A, 26
    map '0', $10, 10

    db  {STRING}
    db  $FE
}
macro menuText(STRING) {

    map ' ', $0000
    map '0', $0001, 10
    map 'A', $000B, 26
    map $2C, $002A
    map '.', $002B
    map '#', $004A // (C)
    map '{', $0023 // Á
    map '}', $0024 // Ã
    map '@', $0025 // Ç
    map '*', $0026 // É
    map '-', $0027 // Í
    map '!', $0028 // Õ
    map '&', $0029 // Ú

    dw  {STRING}
}
macro menuOptionsText(STRING) {

    map ' ', $8000
    map '0', $8001, 10
    map 'A', $800B, 26
    map $2C, $802A
    map '.', $802B
    map '#', $8027
    map '{', $8023 // Á
    map '}', $8024 // Ã
    map '@', $8025 // Ç
    map '*', $8026 // É
    map '-', $8027 // Í
    map '!', $8028 // Õ
    map '&', $8029 // Ú

    dw  {STRING}
}
macro hudText(STRING) {
    map ' ', $8500
    map '0', $8501, 10
    map 'J', $850B
    map 'O', $850C
    map 'G', $850D
    map 'A', $850E
    map 'D', $850F
    map 'R', $8510
    map 'I', $8511
    map 'N', $8512
    map 'S', $8513
    map 'M', $8514
    map 'E', $8515
    map 'T', $8516
    map '{', $8517 // Á
    map 'V', $8519
    map 'Y', $851A

    dw  {STRING}
}
macro ingameMessage(WIDTH, COLUMN, STRING) {
    map ' ', $84
    map '0', $20, 10
    map 'I', $2A
    map 'N', $2B
    map '-', $2C
    map 'C', $2D
    map 'D', $2E
    map 'E', $2F
    map 'S', $30
    map 'T', $31
    map '{', $32
    map 'G', $33
    map 'F', $34
    map 'A', $35
    map 'L', $80
    map 'P', $81
    map 'U', $82
    map 'J', $83
    map 'V', $85
    map 'O', $20

    db  {WIDTH}
    db  {COLUMN}
    db  {STRING}
    db  $00
}
macro ingameMessage2(WIDTH, COLUMN, LINE, STRING) {
    map ' ', $84
    map '0', $20, 10
    map 'I', $2A
    map 'N', $2B
    map '-', $2C
    map 'C', $2D
    map 'D', $2E
    map 'E', $2F
    map 'S', $30
    map 'T', $31
    map '{', $32
    map 'G', $33
    map 'F', $34
    map 'A', $35
    map 'L', $80
    map 'P', $81
    map 'U', $82
    map 'J', $83
    map 'V', $85  
    map 'O', $20

    db  {WIDTH}
    db  {COLUMN}
    db  {LINE}
    db  {STRING}
    db  $00
}
macro endText() {
    dw  $FD
    dw  $0000
}
macro selectStage(STAGE_ID) {
    origin $3918
    dw  $33FC
    origin $391A
    dw  {STAGE_ID} 
}
macro disablePlayerCollision() {
    origin $1265E
    dw $600E
}





// ********************************************************
// * Debug Mode                                           *
// ********************************************************
if ({DEBUG} == 1) {

    if ({DEBUG_INVENCIBILITY} == 1) {
        disablePlayerCollision()
    }

    if ({DEBUG_STAGE} == 1 ) {
        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($0001)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($0002)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0003)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($0007)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($0008)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($0009)
        }
        if ({DEBUG_SUBSTAGE} == 8) {
            selectStage($000A)
        }
        if ({DEBUG_SUBSTAGE} == 9) {
            selectStage($000B)
        }
        if ({DEBUG_SUBSTAGE} == 10) {
            selectStage($000C)
        }
        if ({DEBUG_SUBSTAGE} == 11) {
            selectStage($000D)
        }
    }

    if ({DEBUG_STAGE} == 2 ) {
        
        if ({DEBUG_SUBSTAGE} == 1) {
            selectStage($0011)
        }        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($0012)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($0013)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0015)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($0017)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($0019)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($0018)
        }
    }

    if ({DEBUG_STAGE} == 3 ) {
        
        if ({DEBUG_SUBSTAGE} == 1) {
            selectStage($001A)
        }        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($001B)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($001F)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0031)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($001C)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($0032)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($001E)
        }
        if ({DEBUG_SUBSTAGE} == 8) {
            selectStage($0024)
        }
        if ({DEBUG_SUBSTAGE} == 9) {
            selectStage($001D)
        }
    }

    if ({DEBUG_STAGE} == 4 ) {
        
        if ({DEBUG_SUBSTAGE} == 1) {
            selectStage($0020)
        }        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($0021)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($0022)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0023)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($0029)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($002A)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($0048)
        }
        if ({DEBUG_SUBSTAGE} == 8) {
            selectStage($0035)
        }
        if ({DEBUG_SUBSTAGE} == 9) {
            selectStage($002C)
        }
        if ({DEBUG_SUBSTAGE} == 10) {
            selectStage($002D)
        }
        if ({DEBUG_SUBSTAGE} == 11) {
            selectStage($002E)
        }
    }

    if ({DEBUG_STAGE} == 5 ) {
        
        if ({DEBUG_SUBSTAGE} == 1) {
            selectStage($0036)
        }        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($0037)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($0038)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0039)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($003C)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($0047)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($003E)
        }
        if ({DEBUG_SUBSTAGE} == 8) {
            selectStage($003F)
        }
    }

    if ({DEBUG_STAGE} == 6 ) {
        
        if ({DEBUG_SUBSTAGE} == 1) {
            selectStage($0042)
        }        
        if ({DEBUG_SUBSTAGE} == 2) {
            selectStage($0043)
        }
        if ({DEBUG_SUBSTAGE} == 3) {
            selectStage($0045)
        }
        if ({DEBUG_SUBSTAGE} == 4) {
            selectStage($0044)
        }
        if ({DEBUG_SUBSTAGE} == 5) {
            selectStage($0027)
        }
        if ({DEBUG_SUBSTAGE} == 6) {
            selectStage($0016)
        }
        if ({DEBUG_SUBSTAGE} == 7) {
            selectStage($0028)
        }
    }

}





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
// print "[+] Patching Ending Scripts..."
// origin $00004F44
//     dl patch_end_script_text_1
// origin $000051F4
//     dl patch_end_script_text_2
// origin $000052B4
//     dl patch_end_script_text_3
// origin $00005452
//     dl patch_end_script_text_4
// print "DONE!\n"





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

origin $BA92
patch_menu_options_text_easy:
    menuOptionsText("F{CIL")
patch_menu_options_text_normal:
    menuOptionsText("NORMAL")
patch_menu_options_text_expert:
    menuOptionsText("EXPERT")
patch_menu_options_text_lives_1:
    menuOptionsText("1")
patch_menu_options_text_lives_2:
    menuOptionsText("2")
patch_menu_options_text_lives_3:
    menuOptionsText("3")
patch_menu_options_text_lives_4:
    menuOptionsText("4")
patch_menu_options_text_lives_5:
    menuOptionsText("5")
patch_menu_options_text_lives_9:
    menuOptionsText("9")
patch_menu_options_text_display:
    menuOptionsText("SIM")
    dw $0000
patch_menu_options_text_skip:
    menuOptionsText("N}O")

origin $BB28
    menuText("APERTE A E START     PARA SAIR APERTE START ")
origin $B872
    dw $000C
    dl patch_menu_nextstage

origin $D9DA
patch_menu_options_text_attack:
    menuOptionsText("ATAQUE")
origin $D9EA
patch_menu_options_text_jump:
    menuOptionsText("PULO")
origin $D9F6
patch_menu_options_text_item:
    menuOptionsText("ITEM")
    
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





// ********************************************************
// * Patch HUD (SCORE, ENEMY, PLAYER, LIVES)              *
// ********************************************************
print "[+] Patching HUD..."
origin $0000B68E
    dw  $B090
origin $0000B9EA
    hudText("      ")                   // SCORE

// PATCH PLAYER ON HUD
origin $0000B54A
    dl  patch_hud_player
    dl  $0000B102                       // POSITION ON WINDOW
    dw  $0007                           // LENGHT
// PATCH ENEMY ON HUD
origin $0000B55E
    dl  patch_hud_enemy
    dl  $0000B182                       //  POSITION ON WINDOW
    dw  $0011                           //  LENGHT

// PATCH STAGE ON HUD
origin $0000B572
    dl  patch_hud_stage
    dl  $0000B0B6                       //  POSITION ON WINDOW
    dw  $0007                           //  LENGHT
origin $000B6FA 
    dw  $B0C6                           //  MOVE STAGE #-#

// PATCH REST ON HUD
origin $0000B57C
    dl  patch_hud_rest
    dl  $0000B1BA                       //  POSITION ON WINDOW
    dw  $0005                           //  LENGHT

// PATCH HUD LINE 1
origin $0000BA0A
    dw  $8500                           //  SPACE
    dw  $8524                           //  ITEM FRAME
    dw  $8500                           //  ITEM FRAME
    dw  $8500                           //  ITEM FRAME
    dw  $8D24                           //  ITEM FRAME
    dw  $8500                           //  SPACE
    dw  $8538                           //  XTAL
    dw  $853A                           //  XTAL
    dw  $8500                           //  SPACE

// PATCH HUD LINE 0
origin $0000BA5A
    dw  $8522                           //  ITEM FRAME
    dw  $8523                           //  ITEM FRAME
    dw  $8523                           //  ITEM FRAME
    dw  $8D22                           //  ITEM FRAME

// PATCH HUD LINE 2
    dw  $8524                           //  ITEM FRAME
    dw  $8500                           //  ITEM FRAME
    dw  $8500                           //  ITEM FRAME
    dw  $8D24                           //  ITEM FRAME
    dw  $8500                           //  SPACE
    dw  $8539                           //  XTAL
    dw  $853B                           //  XTAL
    dw  $8500                           //  SPACE

// PATCH HUD LINE 3
    dw  $9522                           //  ITEM FRAME
    dw  $9523                           //  ITEM FRAME
    dw  $9523                           //  ITEM FRAME
    dw  $9D22                           //  ITEM FRAME

// PATCH TO XTAL COUNT
origin $0000B6C4
    dw  $B1B0

origin $000F7B00
patch_hud_player:
    hudText("JOGADOR")                 // PLAYER

patch_hud_enemy:
    hudText("INIMIGO")                 // ENEMY

    // SLOTS AFTER
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C
    dw  $851C

patch_hud_stage:
    hudText("EST{GIO")                 // STAGE

patch_hud_rest:
    hudText("VIDAS")                   // LIVES

origin $000DDDA
    jsr patch_font_score
print "DONE!\n"

// Expanded Area
origin $00100000

// ********************************************************
// * Introduction Script                                  *
// ********************************************************
patch_intro_script_text_1:
    configureText($0018, $00A0, $B506)
    gameText(" OS ANCESTRAIS DA FAMILIA  ")
    gameText("BELMONT ESTAO PREDESTINADOS")
    gameText("A CONFRONTAR O PODER DO MAL")
    gameText("ENCARNADO......DRACULA!    ")
    endText()

patch_intro_script_text_2:
    configureText($0018, $00A0, $B506)
    gameText("EM 1917, UMA CONDESSA TEM  ")
    gameText("ALMEJADO REVIVER O ESPIRITO")
    gameText("DO VAMPIRO MORTO ERAS      ")
    gameText("ATRAS.                     ")
    gameText("SEU NOME ERA ELIZABETH     ")
    gameText("BATHORY.                   ")
    endText()

patch_intro_script_text_3:
    configureText($0018, $00A0, $B506)
    gameText(" PARA REVIVE-LO, ELA       ")
    gameText("PRECISAVA VIAJAR POR TODA A")
    gameText("EUROPA, BUSCANDO ALIADOS DE")
    gameText("TODOS OS PODERES DAS       ")
    gameText("TREVAS.                    ")
    endText()

patch_intro_script_text_4:
    configureText($0018, $00A0, $B506)
    gameText(" DOIS JOVENS CACA-VAMPIROS ")
    gameText("PARTIRAM PARA CUMPRIR SEUS ")
    gameText("DESTINOS... RECHACAR AS    ")
    gameText("HORDAS MALIGNAS E MANDAR O ")
    gameText("VAMPIRO DE VOLTA PARA O    ")
    gameText("INFERNO!                   ")
    endText()

// ********************************************************
// * Ending Script                                        *
// ********************************************************
patch_end_script_text_1:
    configureText($0018, $00A0, $B506)
    gameText("  A RESSUREIÇÃO DE        ")
    gameText("DRÁCULA FOI EVITADA.      ")
    endText()

patch_end_script_text_2:
    configureText($0018, $00A0, $B506)
    gameText("ASSIM, ERIC CUMPRIU SEU    ")
    gameText("DESTINO COMO UM CAÇADOR    ")
    gameText("DE VAMPIROS.               ")
    endText()

patch_end_script_text_3:
    configureText($0018, $00A0, $B506)
    gameText(" PARA REVIVE-LO, ELA       ")
    gameText("PRECISAVA VIAJAR POR TODA A")
    gameText("EUROPA, BUSCANDO ALIADOS DE")
    gameText("TODOS OS PODERES DAS       ")
    gameText("TREVAS.                    ")
    endText()

patch_end_script_text_4:
    configureText($0018, $00B0, $B586)
    gameText(" DOIS JOVENS CACA-VAMPIROS ")
    gameText("PARTIRAM PARA CUMPRIR SEUS ")
    gameText("DESTINOS... RECHACAR AS    ")
    gameText("HORDAS MALIGNAS E MANDAR O ")
    gameText("VAMPIRO DE VOLTA PARA O    ")
    gameText("INFERNO!                   ")
    endText()


// ********************************************************
// * Title Screen Menus and Texts                         *
// ********************************************************
patch_menu_pressstartbutton_text:
    menuText("       APERTE START        ")
patch_menu_pressstartbutton_text_end:

patch_menu_konami_text:
    menuText("#1994 KONAMI, 2020 F.U.R.T.")
patch_menu_konami_text_end:

patch_menu_copyright_text:
    menuText("   WWW.ROMHACKING.NET.BR   ")
patch_menu_copyright_text_end:

patch_menu_1Pstart_text:
    menuText("INICIAR JOGO               ")
patch_menu_1Pstart_text_end:

patch_menu_password_text:
    menuText("COLOCAR SENHA              ")
patch_menu_password_text_end:

patch_menu_options_text:
    menuText("CONFIGURA@!ES              ")
patch_menu_options_text_end:

patch_menu_clear_text:
    menuText("                           ")
patch_menu_clear_text_end:

patch_menu_nextstage:
    menuText(" PARA AVAN@AR")





// ********************************************************
// * Ingame Messages                                      *
// ********************************************************
sprite_ingame_msg_tbl:
    dw  sprite_ingame_msg_stage1start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage2start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage3start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage4start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage5start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage6start-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage1cleared-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage2cleared-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage3cleared-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage4cleared-sprite_ingame_msg_tbl
    dw  sprite_ingame_msg_stage5cleared-sprite_ingame_msg_tbl
sprite_ingame_msg_tbl_final:
    dw  sprite_ingame_msg_stage6cleared-sprite_ingame_msg_tbl
sprite_ingame_msg_stage1start:
    ingameMessage($13, $58, "IN-CIO DO EST{GIO 1")          // STAGE 1 START
sprite_ingame_msg_stage2start:
    ingameMessage($13, $58, "IN-CIO DO EST{GIO 2")          // STAGE 2 START
sprite_ingame_msg_stage3start:
    ingameMessage($13, $58, "IN-CIO DO EST{GIO 3")          // STAGE 3 START
sprite_ingame_msg_stage4start:
    ingameMessage($13, $58, "IN-CIO DO EST{GIO 4")          // STAGE 4 START
sprite_ingame_msg_stage5start:
    ingameMessage($13, $58, "IN-CIO DO EST{GIO 5")          // STAGE 5 START
sprite_ingame_msg_stage6start:
    ingameMessage($17, $50, "IN-CIO DO EST{GIO FINAL")      // FINAL STAGE START
sprite_ingame_msg_stage1cleared:
    ingameMessage($13, $58, "EST{GIO 1 CONCLU-DO")          // STAGE 1 CLEARED          
sprite_ingame_msg_stage2cleared:
    ingameMessage($13, $58, "EST{GIO 2 CONCLU-DO")          // STAGE 2 CLEARED
sprite_ingame_msg_stage3cleared:
    ingameMessage($13, $58, "EST{GIO 3 CONCLU-DO")          // STAGE 3 CLEARED
sprite_ingame_msg_stage4cleared:
    ingameMessage($13, $58, "EST{GIO 4 CONCLU-DO")          // STAGE 4 CLEARED
sprite_ingame_msg_stage5cleared:
    ingameMessage($13, $58, "EST{GIO 5 CONCLU-DO")          // STAGE 5 CLEARED
sprite_ingame_msg_stage6cleared:
    ingameMessage($11, $60, "EST{GIO CONCLU-DO")      // FINAL STAGE CLEARED





// ********************************************************
// * Ingame Messages 2                                    *
// ********************************************************
sprite_ingame_msg_lifebonus:
    ingameMessage2($0E, $48, $70,"PONTOS DE VIDA")            // LIFE BONUS
sprite_ingame_msg_jewelbonus:
    ingameMessage2($06, $88, $88," JOIAS")           // JEWEL BONUS





// ********************************************************
// * New Routines                                         *
// ********************************************************
origin $00120000
patch_font_default_table:
    loadUncompressedGFXtoRAM(font_default, (font_default_end-font_default))
    jmp     $274C

patch_gfx_table:
    cmp.l   #{GFX_FONT_SCORE},a5
    beq     patch_font_score_table
    cmp.l   #{GFX_FONT_DEFAULT},a5
    beq     patch_font_default_table
    cmp.l   #{GFX_INGAME_FONT},a5
    beq     patch_font_ingame_table
    jsr     ({loadCompressedGFXandIncrementPointer}).l
patch_gfx_table_end:  
    jmp     $274C

patch_font_score_table:
    loadUncompressedGFXtoRAM(font_score, (font_score_end-font_score))
    jmp     $274C

patch_font_ingame_table:
    // cmp.w   #$5,({STAGE_COUNTER}).l
    // bpl     patch_font_ingame_table_end
    loadUncompressedGFXtoRAM(font_ingame, (font_ingame_end-font_ingame))
patch_font_ingame_table_end:
    jmp     $274C

patch_font_score:
    loadUncompressedGFX(font_score, $A000, (font_score_end-font_score))
    rts

patch_bloodlines:
    loadUncompressedGFX(gfx_bloodlines, $8000, (gfx_bloodlines_end-gfx_bloodlines))
    jsr     patch_bloodlines_tilemap
    jsr     {drawTilemap}
    rts

patch_stage_call:
    save_registers_to_sp()
    move.w  ({STAGE_COUNTER}).l,d0
    jsr     patch_stage_id
    cmp     #0,d0
    beq     patch_jmp_stage_name_1
    cmp     #1,d0
    beq     patch_jmp_stage_name_2
    cmp     #2,d0
    beq     patch_jmp_stage_name_3
    cmp     #3,d0
    beq     patch_jmp_stage_name_4
    cmp     #4,d0
    beq     patch_jmp_stage_name_5
    cmp     #5,d0
    beq     patch_jmp_stage_name_6   
    jmp     patch_stage_call_end
patch_jmp_stage_name_1:
    jmp     patch_stage_name_1
patch_jmp_stage_name_2:
    jmp     patch_stage_name_2
patch_jmp_stage_name_3:
    jmp     patch_stage_name_3
patch_jmp_stage_name_4:
    jmp     patch_stage_name_4
patch_jmp_stage_name_5:
    jmp     patch_stage_name_5
patch_jmp_stage_name_6:
    jmp     patch_stage_name_6
patch_stage_name_1:
    move.l   #$08860000,d1
    loadUncompressedGFX(gfx_stage_1_name, $8000, (gfx_stage_1_name_end-gfx_stage_1_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_name_2:
    move.l   #$06860000,d1
    loadUncompressedGFX(gfx_stage_2_name, $8000, (gfx_stage_2_name_end-gfx_stage_2_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_name_3:
    move.l   #$09060000,d1
    loadUncompressedGFX(gfx_stage_3_name, $8000, (gfx_stage_3_name_end-gfx_stage_3_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_name_4:
    move.l   #$09060000,d1
    loadUncompressedGFX(gfx_stage_4_name, $8000, (gfx_stage_4_name_end-gfx_stage_4_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_name_5:
    move.l   #$07860000,d1
    loadUncompressedGFX(gfx_stage_5_name, $8000, (gfx_stage_5_name_end-gfx_stage_5_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_name_6:
    move.l   #$07060000,d1
    loadUncompressedGFX(gfx_stage_6_name, $8000, (gfx_stage_6_name_end-gfx_stage_6_name))
    jsr     drawStageNameOnPlaneA
    jmp     patch_stage_call_end
patch_stage_call_end:
    load_register_from_sp()
    jmp     $ACA8

patch_stage_id:
    loadUncompressedGFX(gfx_stage_id, $5520, (gfx_stage_id_end-gfx_stage_id))
    rts

patch_bloodlines_tilemap:
    save_registers_to_sp()
    movea.l #$00FF51C4,a0
    // First group 4x4
    move.w  #$2400,(a0)+
    move.w  #$2401,(a0)+
    move.w  #$2366,(a0)+
    move.w  #$2367,(a0)+
    move.w  #$2413,(a0)+
    move.w  #$2414,(a0)+
    move.w  #$236D,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2426,(a0)+
    move.w  #$2427,(a0)+
    move.w  #$2372,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2439,(a0)+
    move.w  #$243A,(a0)+
    // Second group 4x4
    move.w  #$2402,(a0)+
    move.w  #$2403,(a0)+
    move.w  #$2404,(a0)+
    move.w  #$2405,(a0)+
    move.w  #$2415,(a0)+
    move.w  #$2416,(a0)+
    move.w  #$2417,(a0)+
    move.w  #$2418,(a0)+
    move.w  #$2428,(a0)+
    move.w  #$2429,(a0)+
    move.w  #$242A,(a0)+
    move.w  #$242B,(a0)+
    move.w  #$243B,(a0)+
    move.w  #$243C,(a0)+
    move.w  #$243D,(a0)+
    move.w  #$243E,(a0)+

    movea.l #$FF5300,a0
    // Third group 4x4
    move.w  #$2406,(a0)+
    move.w  #$2407,(a0)+
    move.w  #$2408,(a0)+
    move.w  #$2409,(a0)+
    move.w  #$2419,(a0)+
    move.w  #$241A,(a0)+
    move.w  #$241B,(a0)+
    move.w  #$241C,(a0)+
    move.w  #$242C,(a0)+
    move.w  #$242D,(a0)+
    move.w  #$242E,(a0)+
    move.w  #$242F,(a0)+
    move.w  #$243F,(a0)+
    move.w  #$2440,(a0)+
    move.w  #$2441,(a0)+
    move.w  #$2442,(a0)+
    // Fourth group 4x4
    move.w  #$240A,(a0)+
    move.w  #$240B,(a0)+
    move.w  #$240C,(a0)+
    move.w  #$240D,(a0)+
    move.w  #$241D,(a0)+
    move.w  #$241E,(a0)+
    move.w  #$241F,(a0)+
    move.w  #$2420,(a0)+
    move.w  #$2430,(a0)+
    move.w  #$2431,(a0)+
    move.w  #$2432,(a0)+
    move.w  #$2433,(a0)+
    move.w  #$2443,(a0)+
    move.w  #$2444,(a0)+
    move.w  #$2445,(a0)+
    move.w  #$2446,(a0)+
    // fifth group 4x4
    move.w  #$240E,(a0)+
    move.w  #$240F,(a0)+
    move.w  #$2410,(a0)+
    move.w  #$2411,(a0)+
    move.w  #$2421,(a0)+
    move.w  #$2422,(a0)+
    move.w  #$2423,(a0)+
    move.w  #$2424,(a0)+
    move.w  #$2434,(a0)+
    move.w  #$2435,(a0)+
    move.w  #$2436,(a0)+
    move.w  #$2437,(a0)+
    move.w  #$2447,(a0)+
    move.w  #$2448,(a0)+
    move.w  #$2449,(a0)+
    move.w  #$244A,(a0)+
    // sixth group 4x4
    move.w  #$2412,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2425,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2438,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$244B,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+
    move.w  #$2000,(a0)+

    load_register_from_sp()
    rts

drawStageNameOnPlaneA:
    save_registers_to_sp()
    move.l  #$50000003,d0
    add.l   d1,d0
    move.w  #$0003,d7
    move.w  #$0000,d4
drawStageNameOnPlaneA_loop_line:
    move.w  #$001A,d6
    move.l  d0,({VDP_CTRL}).l
drawStageNameOnPlaneA_loop_column:
    move.w  d4,d5
    add.w   #$8400,d5
    move.w  d5,({VDP_DATA}).l
    add.w   #$0001,d4
    dbf     d6,drawStageNameOnPlaneA_loop_column
    add.l   #$00800000,d0
    dbf     d7,drawStageNameOnPlaneA_loop_line
    load_register_from_sp()
    rts

drawBioCardJimOnPlaneB:
    save_registers_to_sp()
    move.l  #$631A0003,d0
    add.l   d1,d0
    move.w  #$0005,d7
    move.w  #$0000,d4
drawBioCardJimOnPlaneB_loop_line:
    move.w  #$0017,d6
    move.l  d0,({VDP_CTRL}).l
drawBioCardJimOnPlaneB_loop_column:
    move.w  d4,d5
    add.w   #$8300,d5
    move.w  d5,({VDP_DATA}).l
    add.w   #$0001,d4
    dbf     d6,drawBioCardJimOnPlaneB_loop_column
    add.l   #$00800000,d0
    dbf     d7,drawBioCardJimOnPlaneB_loop_line
    load_register_from_sp()
    rts

drawBioCardEricOnPlaneB:
    save_registers_to_sp()
    move.l  #$699A0003,d0
    add.l   d1,d0
    move.w  #$0005,d7
    move.w  #$0000,d4
drawBioCardEricOnPlaneB_loop_line:
    move.w  #$0017,d6
    move.l  d0,({VDP_CTRL}).l
drawBioCardEricOnPlaneB_loop_column:
    move.w  d4,d5
    add.w   #$E480,d5
    move.w  d5,({VDP_DATA}).l
    add.w   #$0001,d4
    dbf     d6,drawBioCardEricOnPlaneB_loop_column
    add.l   #$00800000,d0
    dbf     d7,drawBioCardEricOnPlaneB_loop_line
    load_register_from_sp()
    rts

patch_menu_inside_options:
    moveq   #$27,d2
    moveq   #0,d0
    move.w  #$E000,d1
    movea.l ($FF92D4).l,a0
    movea.l ($FF92DC).l,a1
patch_menu_inside_options_loop:
    andi.w  #$C07E,d1
    dl      $48E7E0C0   // d0-d2/a0-a1,-(sp)
    move.w  #$FF00,d6
    jsr     ($AD2A).l
    dl      $4CDF0307   // (sp)+,d0-d2/a0-a1
    addq.w  #1,d0
    addq.w  #2,d1
    dbf     d2,patch_menu_inside_options_loop
    save_registers_to_sp()
    movea.l #$FF1210,a0
    move.w  #$8000,(a0)+
    move.w  #$8000,(a0)+
    move.w  #$800D,(a0)+            // C
    move.w  #$8019,(a0)+            // O
    move.w  #$8018,(a0)+            // N
    move.w  #$8010,(a0)+            // F
    move.w  #$8013,(a0)+            // I
    move.w  #$8011,(a0)+            // G
    move.w  #$801F,(a0)+            // U
    move.w  #$801C,(a0)+            // R
    move.w  #$800B,(a0)+            // A
    move.w  #$8025,(a0)+            // C
    move.w  #$8028,(a0)+            // O
    move.w  #$800F,(a0)+            // E
    move.w  #$801D,(a0)+            // S
    movea.l #$FF1310,a0
    move.w  #$800E,(a0)+            // D
    move.w  #$8013,(a0)+            // I
    move.w  #$8010,(a0)+            // F
    move.w  #$8013,(a0)+            // I
    move.w  #$800D,(a0)+            // C
    move.w  #$801F,(a0)+            // U
    move.w  #$8016,(a0)+            // L
    move.w  #$800E,(a0)+            // D
    move.w  #$800B,(a0)+            // A
    move.w  #$800E,(a0)+            // D
    move.w  #$800F,(a0)+            // E
    movea.l #$FF1410,a0
    move.w  #$8020,(a0)+            // V
    move.w  #$8013,(a0)+            // I
    move.w  #$800E,(a0)+            // D
    move.w  #$800B,(a0)+            // A
    move.w  #$801D,(a0)+            // S
    move.w  #$8000,(a0)+
    move.w  #$8000,(a0)+
    movea.l #$FF1510,a0
    move.w  #$800D,(a0)+            // C
    move.w  #$8019,(a0)+            // O
    move.w  #$8018,(a0)+            // N
    move.w  #$801E,(a0)+            // T
    move.w  #$801C,(a0)+            // R
    move.w  #$8019,(a0)+            // O
    move.w  #$8016,(a0)+            // L
    move.w  #$800F,(a0)+            // E
    move.w  #$801D,(a0)+            // S
    movea.l #$FF1910,a0
    move.w  #$8017,(a0)+            // M
    move.w  #$8029,(a0)+            // U
    move.w  #$801D,(a0)+            // S
    move.w  #$8013,(a0)+            // I
    move.w  #$800D,(a0)+            // C
    move.w  #$800B,(a0)+            // A
    movea.l #$FF1A10,a0
    move.w  #$800F,(a0)+            // E
    move.w  #$8010,(a0)+            // F
    move.w  #$800F,(a0)+            // E
    move.w  #$8013,(a0)+            // I
    move.w  #$801E,(a0)+            // T
    move.w  #$8019,(a0)+            // O
    move.w  #$801D,(a0)+            // S
    movea.l #$FF1B10,a0
    move.w  #$800E,(a0)+            // D
    move.w  #$800F,(a0)+            // E
    move.w  #$8017,(a0)+            // M
    move.w  #$8019,(a0)+            // O
    move.w  #$8018,(a0)+            // N
    move.w  #$801D,(a0)+            // S
    move.w  #$801E,(a0)+            // T
    move.w  #$801C,(a0)+            // R
    move.w  #$800B,(a0)+            // A   
    move.w  #$8025,(a0)+            // C 
    move.w  #$8024,(a0)+            // A
    move.w  #$8019,(a0)+            // O
    movea.l #$FF1C0C,a0
    move.w  #$800B,(a0)+            // A 
    move.w  #$801A,(a0)+            // P 
    move.w  #$800F,(a0)+            // E
    move.w  #$801C,(a0)+            // R
    move.w  #$801E,(a0)+            // T
    move.w  #$800F,(a0)+            // E
    move.w  #$8000,(a0)+            //  
    move.w  #$801D,(a0)+            // S
    move.w  #$801E,(a0)+            // T    
    move.w  #$800B,(a0)+            // A 
    move.w  #$801C,(a0)+            // R
    move.w  #$801E,(a0)+            // T
    move.w  #$8000,(a0)+            // 
    move.w  #$801A,(a0)+            // P 
    move.w  #$800B,(a0)+            // A 
    move.w  #$801C,(a0)+            // R   
    move.w  #$800B,(a0)+            // A 
    move.w  #$8000,(a0)+            //  
    move.w  #$801D,(a0)+            // S   
    move.w  #$800B,(a0)+            // A   
    move.w  #$8013,(a0)+            // I
    move.w  #$801C,(a0)+            // R
    load_register_from_sp()
    move.l  #{M68K_RAM},d4
    move.l  #$E000,d5
    move.w  #$1000,d6
    move.w  #$8F02,d7
    jmp     ($2422).l

patch_characters_bio:
    loadUncompressedGFX(gfx_bio_card_john, $6000, (gfx_bio_card_john_end-gfx_bio_card_john))
    loadUncompressedGFX(gfx_bio_card_eric, $9000, (gfx_bio_card_eric_end-gfx_bio_card_eric))
    jsr     drawBioCardJimOnPlaneB
    jsr     drawBioCardEricOnPlaneB
    loadUncompressedGFX(font_card_bio, $2000, (font_card_bio_end-font_card_bio)) // Bug Fix
    jmp     ($312E0).l

load_new_sprite_ingame_msg:
    loadUncompressedGFX(font_ingame, $0400, (font_ingame_end-font_ingame))
    lea     (sprite_ingame_msg_tbl).l,a6
    rts





// ********************************************************
// * Graphics                                             *
// ********************************************************
origin $00140000
font_default:
    insert "patch/font_default.bin"
font_default_end:

font_card_bio:
    insert "patch/font_card_bio.bin"
font_card_bio_end:

font_ingame:
    insert "patch/font_ingame.bin"
font_ingame_end:

font_score:
    insert "patch/font_score.bin"
font_score_end:

gfx_bloodlines:
    insert "patch/subtitle.bin"
gfx_bloodlines_end:

gfx_stage_id:
    insert "patch/stage_id.bin"
gfx_stage_id_end:

gfx_stage_1_name:
    insert "patch/stage_1_name.bin"
gfx_stage_1_name_end:

gfx_stage_2_name:
    insert "patch/stage_2_name.bin"
gfx_stage_2_name_end:

gfx_stage_3_name:
    insert "patch/stage_3_name.bin"
gfx_stage_3_name_end:

gfx_stage_4_name:
    insert "patch/stage_4_name.bin"
gfx_stage_4_name_end:

gfx_stage_5_name:
    insert "patch/stage_5_name.bin"
gfx_stage_5_name_end:

gfx_stage_6_name:
    insert "patch/stage_6_name.bin"
gfx_stage_6_name_end:

gfx_bio_card_john:
    insert "patch/bio_card_john.bin"
gfx_bio_card_john_end:

gfx_bio_card_eric:
    insert "patch/bio_card_eric.bin"
gfx_bio_card_eric_end: