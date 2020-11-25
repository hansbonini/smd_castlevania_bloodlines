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