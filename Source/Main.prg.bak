*--------------*
 FUNCTION MAIN()

 LOCAL aCampos, aTitulos

 SET CENTURY    ON
 SET EPOCH      TO 1950
 SET DATE       BRITISH
 SET DELETE     ON
 SET EXCLUSIVE  OFF

 INICIA_BANCO_DADOS()

 @ 01,00 SAY PadC(" CADASTRO DE PRODUTOS ",80)
 @ 01,00 SAY Date()
 @ 01,72 SAY Time()
 @ 02,00 SAY Replicate("-",80)
 @ 23,00 SAY Replicate("-",80)
 @ 24,00 SAY PadC(" INS - INCLUIR / ENTER - ALTERAR / DEL - EXCLUIR / LETRA - BUSCAR / F2 - REL ", 80)

 SELECT PRODUTOS
 OrdSetFocus("NOME")
 DBGoTop()

 aTitulos:={"Codigo","Nome" ,"Preco" }
 aCampos :={"CODIGO", "NOME", "PRECO"}

 DBEdit(03, 00, 22, 80, aCampos,"F_CADASTRO_PRODUTOS",,aTitulos)

 RETURN NIL

*----------------------------------*
 FUNCTION F_CADASTRO_PRODUTOS(nModo)

 IF nModo==4
    IF LastKey()==22
       INCLUIR()
     ELSEIF LastKey()==13
       ALTERAR()
     ELSEIF LastKey()==7
       EXCLUIR()
     ELSEIF LastKey()>=32 .AND. LastKey()<127
       BUSCAR()
     ELSEIF LASTKEY()==-1
       IMPRIMIR()
    ENDIF
 ENDIF

 RETURN 2