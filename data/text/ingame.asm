origin $00102000

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

