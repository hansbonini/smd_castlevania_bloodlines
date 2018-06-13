* **********************************************
* [SMD] Castlevania Bloodlines (U) [!]
* **********************************************
* HUD Patch
* **********************************************

  * PATCH SCORE ON HUD
  org $0000B9EA
patch_hud_score:
  dc.w  $8500 ; P
  dc.w  $8500 ; O
  dc.w  $8500 ; N
  dc.w  $8500 ; T
  dc.w  $8500 ; U
  dc.w  $8500 ; U
  org   $B68E
  dc.w  $B090

  * PATCH PLAYER ON HUD
  org   $0000B54A
  dc.l  patch_hud_player
  dc.l  $0000B102  ; POSITION ON WINDOW
  dc.w  $0007      ; LENGHT

  * PATCH ENEMY ON HUD
  org   $0000B55E
  dc.l  patch_hud_enemy
  dc.l  $0000B182  ; POSITION ON WINDOW
  dc.w  $0011      ; LENGHT

  * PATCH STAGE ON HUD
  org   $0000B572
  dc.l  patch_hud_stage
  dc.l  $0000B0B6  ; POSITION ON WINDOW
  dc.w  $0007      ; LENGHT
  org   $000B6FA
  dc.w  $B0C6       ; MOVE STAGE #-#

  * PATCH REST ON HUD
  org   $0000B57C
  dc.l  patch_hud_rest
  dc.l  $0000B1BA  ; POSITION ON WINDOW
  dc.w  $0005      ; LENGHT

  * PATCH HUD LINE 1
  org   $0000BA0A
  dc.w  $8500 ; SPACE
  dc.w  $8524 ; ITEM FRAME
  dc.w  $8500 ; ITEM FRAME
  dc.w  $8500 ; ITEM FRAME
  dc.w  $8D24 ; ITEM FRAME
  dc.w  $8500 ; SPACE
  dc.w  $8538 ; XTAL
  dc.w  $853A ; XTAL
  dc.w  $8500 ; SPACE

  * PATCH HUD LINE 0
  org   $0000BA5A
  dc.w  $8522 ; ITEM FRAME
  dc.w  $8523 ; ITEM FRAME
  dc.w  $8523 ; ITEM FRAME
  dc.w  $8D22 ; ITEM FRAME

  * PATCH HUD LINE 2
  dc.w  $8524 ; ITEM FRAME
  dc.w  $8500 ; ITEM FRAME
  dc.w  $8500 ; ITEM FRAME
  dc.w  $8D24 ; ITEM FRAME
  dc.w  $8500 ; SPACE
  dc.w  $8539 ; XTAL
  dc.w  $853B ; XTAL
  dc.w  $8500 ; SPACE

  *PATCH HUD LINE 3
  dc.w  $9522 ; ITEM FRAME
  dc.w  $9523 ; ITEM FRAME
  dc.w  $9523 ; ITEM FRAME
  dc.w  $9D22 ; ITEM FRAME

  *PATCH TO XTAL COUNT
  org   $0000B6C4
  dc.w  $B1B0

  org $000F7B00
patch_hud_player:
  dc.w  $850B ; J
  dc.w  $850C ; O
  dc.w  $850D ; G
  dc.w  $850E ; A
  dc.w  $850F ; D
  dc.w  $850C ; O
  dc.w  $8510 ; R

patch_hud_enemy:
  dc.w  $8511 ; I
  dc.w  $8512 ; N
  dc.w  $8511 ; I
  dc.w  $8514 ; M
  dc.w  $8511 ; I
  dc.w  $850D ; G
  dc.w  $850C ; O
  * SPACES BEFORE
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C
  dc.w  $851C

patch_hud_stage:
  dc.w  $8515 ; E
  dc.w  $8513 ; S
  dc.w  $8516 ; T
  dc.w  $8517 ; Á
  dc.w  $850D ; G
  dc.w  $8511 ; I
  dc.w  $850C ; O

patch_hud_rest:
  dc.w  $8518 ; V
  dc.w  $8511 ; I
  dc.w  $850F ; D
  dc.w  $850E ; A
  dc.w  $8519 ; S
