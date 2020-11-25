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

include "asm/globals.asm"
include "asm/macros.asm"
include "asm/debug.asm"
include "asm/pointers.asm"
include "data/text/options_menu.asm"
include "data/text/hud.asm"
include "data/text/intro.asm"
include "data/text/ending.asm"
include "data/text/credits.asm"
include "data/text/ingame.asm"
include "data/text/title_screen.asm"



// ********************************************************
// * New Routines                                         *
// ********************************************************
origin $00120000
patch_font_score_table:
    loadUncompressedGFXtoRAM(font_score, (font_score_end-font_score))
    jmp     patch_gfx_table_end

patch_font_default_table:
    loadUncompressedGFXtoRAM(font_default, (font_default_end-font_default))
    jmp     patch_gfx_table_end

patch_gfx_table:
    cmp.l   #{GFX_FONT_SCORE},a5
    beq     patch_font_score_table
    cmp.l   #{GFX_FONT_DEFAULT},a5
    beq     patch_font_default_table
    cmp.l   #{GFX_INTRO_FONT},a5
    beq     patch_font_intro_table
    cmp.l   #{GFX_INGAME_FONT},a5
    beq     patch_font_ingame_table
    jsr     ({loadCompressedGFXandIncrementPointer}).l
patch_gfx_table_end:  
    jmp     $274C

patch_font_intro_table:
    loadUncompressedGFXtoRAM(font_intro, (font_intro_end-font_intro))
    jmp     patch_gfx_table_end

patch_font_ingame_table:
    // cmp.w   #$5,({STAGE_COUNTER}).l
    // bpl     patch_font_ingame_table_end
    loadUncompressedGFXtoRAM(font_ingame, (font_ingame_end-font_ingame))
patch_font_ingame_table_end:
    jmp     patch_gfx_table_end

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

patch_credits_boss_name:
    clr     d0
    move.w  (credits_boss_table,pc,d1),d0
    add.w   d0,d0
    lea     (credits_boss_names,pc,d1).l,a0
    adda.l  d0,a0
    jmp     ($8196).l

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
    insert "data/gfx/font_default.bin"
font_default_end:

font_intro:
    insert "data/gfx/font_intro.bin"
font_intro_end:

font_card_bio:
    insert "data/gfx/font_card_bio.bin"
font_card_bio_end:

font_ingame:
    insert "data/gfx/font_ingame.bin"
font_ingame_end:

font_score:
    insert "data/gfx/font_score.bin"
font_score_end:

gfx_bloodlines:
    insert "data/gfx/subtitle.bin"
gfx_bloodlines_end:

gfx_stage_id:
    insert "data/gfx/stage_id.bin"
gfx_stage_id_end:

gfx_stage_1_name:
    insert "data/gfx/stage_1_name.bin"
gfx_stage_1_name_end:

gfx_stage_2_name:
    insert "data/gfx/stage_2_name.bin"
gfx_stage_2_name_end:

gfx_stage_3_name:
    insert "data/gfx/stage_3_name.bin"
gfx_stage_3_name_end:

gfx_stage_4_name:
    insert "data/gfx/stage_4_name.bin"
gfx_stage_4_name_end:

gfx_stage_5_name:
    insert "data/gfx/stage_5_name.bin"
gfx_stage_5_name_end:

gfx_stage_6_name:
    insert "data/gfx/stage_6_name.bin"
gfx_stage_6_name_end:

gfx_bio_card_john:
    insert "data/gfx/bio_card_john.bin"
gfx_bio_card_john_end:

gfx_bio_card_eric:
    insert "data/gfx/bio_card_eric.bin"
gfx_bio_card_eric_end:
