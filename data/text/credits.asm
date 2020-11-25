origin $00100800
// ******************************************************
// * Credits                                            *
// ******************************************************
credits:
    gameText("      CASTLEVANIA BLOODLINES       ")
    gameText("              EQUIPE               ")
    gameText("          PROGRAMA@}O MK1          ")
    gameText("              HANATEN              ")
    gameText("      PROGRAMA@}O DE INIMIGOS      ")
    gameText("           TAKASHI TAKEDA          ")
    gameText(" PROGRAMA@}O ARMADILHAS E INIMIGOS ")
    gameText("           KENICHI HORIO           ")
    gameText("      PROGRAMADOR FREELANCER       ")
    gameText("            KOJI KOMATA            ")
    gameText("            PROGRAMA@}O            ")
    gameText("         HIDENARI INAMURA          ")
    gameText("           DESIGNER GERAL          ")
    gameText("              BUNMIN               ")
    gameText("              DESIGN               ")
    gameText("              MAMUUN               ")
    gameText("          DESIGN ESPECIAL          ")
    gameText("                TAT                ")
    gameText("          NORIO TAKEMOTO           ")
    gameText("        PROGRAMA@}O SONORA         ")
    gameText("            MICHIRU YAMANE         ")
    gameText("        DESIGN DE EMBALAGEM        ")
    gameText("            M. YOSHIHASHI          ")
    gameText("            KAORI SASAKI           ")
    gameText("      AGRADECIMENTOS ESPECIAIS     ")
    gameText("            H. TAKEUCHI            ")
    gameText("            K. IKETANI             ")
    gameText("            K. KINJYO              ")
    gameText("            T. SHINGUU             ")
    gameText("            N. TANAKA              ")
    gameText("            S. YOMOTA              ")
    gameText("            T. NIIMI               ")
    gameText("            T. YABE                ")
    gameText("        DIREITOS LEGAIS POR        ")
    gameText(" 1994 TOKUMASHOTEN INTERMEDIA INC. ")
    gameText("       SUPERVIS}O DO PROJETO       ")
    gameText("          TOMIKAZU KIRITA          ")
    gameText("        OBRIGADO POR JOGAR!        ")
    gameText("     TENTE A DIFICULDADE NORMAL!   ")
    gameText("     TENTE A DIFICULDADE EXPERT!   ")
    gameText("             PARABENS!             ")
    gameText("    VOCE E O GRANDE MESTRE DOS     ")
    gameText("       MATADORES DE VAMPIRO!       ")

origin $886A
credits_boss_table:
    dw $4E75
    dw credits_boss_names_armor_battle-credits_boss_table
    dw credits_boss_names_golem-credits_boss_table
    dw credits_boss_names_gargoyle-credits_boss_table
//    dw credits_boss_names_gearsteamer-credits_boss_table
//    dw credits_boss_names_pricessofmoss-credits_boss_table
//    dw credits_boss_names_death-credits_boss_table
//    dw credits_boss_names_medusa-credits_boss_table
//    dw credits_boss_names_dracula-credits_boss_table

origin $826E
credits_boss_names:
credits_boss_names_armor_battle:
    bossNames($28,"ARMADURA LOUCA")
credits_boss_names_golem:
    bossNames($34,"GOLEM")
credits_boss_names_gargoyle:
    bossNames($28,"GARGULA")
//credits_boss_names_gearsteamer:
//    bossNames($28,"VAPORIZADOR ENGRENADO")
//credits_boss_names_pricessofmoss:
//    bossNames($28,"PRINCESA MARIPOSA")
//credits_boss_names_death:
//    bossNames($34,"MORTE")
//credits_boss_names_medusa:
//    bossNames($30,"MEDUSA")
//credits_boss_names_dracula:
//    bossNames($30,"DRACULA")