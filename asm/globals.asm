
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
define GFX_INTRO_FONT($000AC6CE)
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