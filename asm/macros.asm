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
    map '.', $13
    map '_', $12
    map $2C, $11 // ','
    map '!', $10
    map '1', $14
    map '7', $15
    map '9', $16
    map 'A', $17
    map 'B', $18
    map 'C', $19
    map 'D', $1A
    map 'E', $1B
    map 'F', $1C   
    map 'G', $1D
    map 'H', $1E
    map 'I', $1F
    map 'J', $20
    map 'L', $21
    map 'M', $22
    map 'N', $23
    map 'O', $24
    map 'P', $25
    map 'R', $26
    map 'S', $27
    map 'T', $28
    map 'U', $29
    map 'V', $2A
    map 'Y', $2B
    map 'Z', $2C
    map '{', $2D
    map '}', $2E
    map '@', $2F
    map '*', $30
    map '-', $31
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

macro bossNames(COLUMN, STRING) {
    map ' ', $00
    map 'A', $16
    map 'B', $18
    map 'C', $1A
    map 'D', $1C
    map 'E', $1E
    map 'F', $29
    map 'G', $22
    map 'H', $24
    map 'I', $26
    map 'J', $28
    map 'K', $2A
    map 'L', $2C
    map 'M', $2E
    map 'N', $30
    map 'O', $32
    map 'P', $34
    map 'Q', $36
    map 'R', $38
    map 'S', $3A  
    map 'T', $3C
    map 'U', $3E
    map 'V', $40
    map 'W', $42
    map 'X', $43
    map 'Y', $46
    map 'Z', $48

    dw  {COLUMN}
    db  {STRING}
    db  $FD
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