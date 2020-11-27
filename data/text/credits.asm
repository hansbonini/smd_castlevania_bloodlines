constant NEWLINE($FE)
constant ENDSTRING($FD)

origin $00100800
// ******************************************************
// * Credits                                            *
// ******************************************************
credits_table:
    dw  (credits-credits)
    dw  (credits_1-credits)
    dw  (credits_2-credits)
    dw  (credits_3-credits)
    dw  (credits_4-credits)
    dw  (credits_5-credits)
    dw  (credits_6-credits)
    dw  (credits_7-credits)
    dw  (credits_8-credits)
    dw  (credits_9-credits)
credits:
credits_1:
    dw  $0140
    creditsTextPosition($05,$04)  
    creditsText("            CASTLEVANIA            ")
    db  NEWLINE
    creditsTextPosition($06,$04)  
    creditsText("        LINHAGENS SANGU-NEAS       ")
    db  NEWLINE
    creditsTextPosition($08,$04)  
    creditsText("               EQUIPE              ")
    db  ENDSTRING
credits_2:
    dw  $0180
    creditsTextPosition($02,$04)  
    creditsText("          PROGRAMA@}O MK1          ")
    db  NEWLINE
    creditsTextPosition($03,$04)  
    creditsText("              HANATEN              ")
    db  NEWLINE
    creditsTextPosition($04,$04)  
    creditsText("      PROGRAMA@}O DE INIMIGOS      ")
    db  NEWLINE
    creditsTextPosition($05,$04)  
    creditsText("           TAKASHI TAKEDA          ")
    db  ENDSTRING
credits_3:
    dw  $0240
    creditsTextPosition($02,$04)  
    creditsText(" PROGRAMA@}O ARMADILHAS E INIMIGOS ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText("           KENICHI HORIO           ")
    db  NEWLINE
    creditsTextPosition($05,$04) 
    creditsText("      PROGRAMADOR FREELANCER       ")
    db  NEWLINE
    creditsTextPosition($06,$04) 
    creditsText("            KOJI KOMATA            ")
    db  NEWLINE
    creditsTextPosition($07,$04) 
    creditsText("            PROGRAMA@}O            ")
    db  NEWLINE
    creditsTextPosition($08,$04) 
    creditsText("         HIDENARI INAMURA          ")
    db  ENDSTRING
credits_4:
    dw  $0180
    creditsTextPosition($05,$04) 
    creditsText("           DESIGNER GERAL          ")
    db  NEWLINE
    creditsTextPosition($06,$04) 
    creditsText("              BUNMIN               ")
    db  NEWLINE
    creditsTextPosition($08,$04) 
    creditsText("              DESIGN               ")
    db  NEWLINE
    creditsTextPosition($09,$04) 
    creditsText("              MAMUUN               ")
    db  ENDSTRING
credits_5:
    dw  $0180
    creditsTextPosition($02,$04) 
    creditsText("          DESIGN ESPECIAL          ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText("                TAT                ")
    db  NEWLINE
    creditsTextPosition($04,$04) 
    creditsText("          NORIO TAKEMOTO           ")
    db  ENDSTRING
credits_6:
    dw  $0240
    creditsTextPosition($02,$04) 
    creditsText("        PROGRAMA@}O SONORA         ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText("           ATSUSHI FUJIO           ")
    db  NEWLINE
    creditsTextPosition($04,$04) 
    creditsText("           OSAMU KASAI             ")
    db  NEWLINE 
    creditsTextPosition($06,$04) 
    creditsText("          DESIGN SONORO            ")
    db  NEWLINE
    creditsTextPosition($07,$04) 
    creditsText("          MICHIRU YAMANE           ")
    db  ENDSTRING
credits_7:
    dw  $0180
    creditsTextPosition($02,$04) 
    creditsText("        DESIGN DE EMBALAGEM        ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText("            M. YOSHIHASHI          ")
    db  NEWLINE
    creditsTextPosition($04,$04) 
    creditsText("            KAORI SASAKI           ")
    db  ENDSTRING
credits_8:
    dw  $0240
    creditsTextPosition($02,$04) 
    creditsText("      AGRADECIMENTOS ESPECIAIS     ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText(" H. TAKEUCHI            K. IKETANI ")
    db  NEWLINE
    creditsTextPosition($04,$04) 
    creditsText(" K. KINJYO              T. SHINGUU ")
    db  NEWLINE
    creditsTextPosition($05,$04) 
    creditsText(" N. TANAKA              S. YOMOTA  ")
    db  NEWLINE
    creditsTextPosition($06,$04) 
    creditsText(" T. NIIMI               T. YABE    ")
    db  NEWLINE
    creditsTextPosition($08,$04) 
    creditsText("        DIREITOS LEGAIS POR        ")
    db  NEWLINE
    creditsTextPosition($09,$04) 
    creditsText("   TOKUMASHOTEN INTERMEDIA INC.    ")
    db  ENDSTRING
credits_9:
    dw  $0180
    creditsTextPosition($02,$04) 
    creditsText("             SUPERVIS}O            ")
    db  NEWLINE
    creditsTextPosition($03,$04) 
    creditsText("           YUTAKA HARUKI           ")
    db  NEWLINE
    creditsTextPosition($05,$04) 
    creditsText("       SUPERVIS}O DO PROJETO       ")
    db  NEWLINE
    creditsTextPosition($06,$04) 
    creditsText("          TOMIKAZU KIRITA          ")
    db  ENDSTRING

credits_congratulation:
credits_congratulation_1:
    dw $0040
    dw $000A
    creditsText("      OBRIGADO POR JOGAR!      ")
    db NEWLINE
    creditsText("  TENTE A D-FICULDADE NORMAL!  ")
    db ENDSTRING
credits_congratulation_2:
    dw $0040
    dw $00A0
    creditsText("  TENTE A D-FICULDADE EXPERT!  ")
    db ENDSTRING
credits_congratulation_3:
    dw $0040
    dw $0090
    dw $B500
    creditsText("           PARAB*NS!           ")
    db NEWLINE
    creditsText("  VOC_ * O GRANDE MESTRE DOS   ")
    db NEWLINE
    creditsText("     MATADORES DE VAMPIRO!     ")
    db ENDSTRING


credits_boss_table:
    dw $4E75
    dw credits_boss_names_armor_battle-credits_boss_names
    dw credits_boss_names_golem-credits_boss_names
    dw credits_boss_names_gargoyle-credits_boss_names
    dw credits_boss_names_gearsteamer-credits_boss_names
    dw credits_boss_names_pricessofmoss-credits_boss_names
    dw credits_boss_names_death-credits_boss_names
    dw credits_boss_names_medusa-credits_boss_names
    dw credits_boss_names_dracula-credits_boss_names
credits_boss_names:
credits_boss_names_armor_battle:
    bossNames($24,"ARMADURA LOUCA ")
credits_boss_names_golem:
    bossNames($34,"GOLEM")
credits_boss_names_gargoyle:
    bossNames($28,"G{RGULA")
credits_boss_names_gearsteamer:
    bossNames($22,"VAPORIZADOR ENGRENADO")
credits_boss_names_pricessofmoss:
    bossNames($28,"PRINCESA MARIPOSA")
credits_boss_names_death:
    bossNames($34,"MORTE")
credits_boss_names_medusa:
    bossNames($30,"MEDUSA")
    db $00
credits_boss_names_dracula:
    bossNames($30,"DR{CULA")