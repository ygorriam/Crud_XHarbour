#INCLUDE "WINUSER.CH"

*-----------------*
FUNCTION ALTERAR()

 LOCAL GetList:={}, nCodigo:=0, cNome:="", nPreco:=0, dCadastro:=CToD(''), cInativo:="", lRetorno := .F., lAchou := .F.


 SELECT PRODUTOS
 SET ORDER TO 1
 DBGOTOP()

 IF PRODUTOS->CODIGO == 0
     MessageBox(, "Não há produtos cadastrados para alterar.", "Atenção")
     RETURN NIL
 ENDIF

 @ 03,00 CLEAR TO 22,80
 @ 02,00 SAY PadC("ALTERACAO DE PRODUTOS", 80)
 @ 03,00 SAY Replicate("-", 80)
 @ 04,10 SAY "CODIGO A ALTERAR: " GET nCodigo PICTURE "99999"

 READ

 IF LastKey() == 27
     RETURN NIL
 ENDIF



 IF DBSEEK(nCodigo)
     lAchou := .T.
 ELSE
     MessageBox(, "Código não encontrado!", "Atenção")
     RETURN NIL
 ENDIF

 IF lAchou
     cNome    := NOME
     nPreco   := PRECO
     dCadastro:= CADASTRO
     cInativo := IIf(INATIVO, "S", "N")

     @ 03,00 CLEAR TO 22,80
     @ 02,00 SAY PadC("ALTERAÇÃO DE PRODUTOS", 80)
     @ 03,00 SAY Replicate("-", 80)
     @ 04,10 SAY "CODIGO:           " GET nCodigo    PICTURE "99999" WHEN .F. VALID nCodigo > 0
     @ 05,10 SAY "NOME:             " GET cNome      PICTURE "@!" VALID !Empty(cNome)
     @ 06,10 SAY "PRECO:            " GET nPreco     PICTURE "999.99" VALID nPreco > 0
     @ 07,10 SAY "CADASTRO:         " GET dCadastro VALID dCadastro >= Date()
     @ 08,10 SAY "INATIVO (S/N):    " GET cInativo   PICTURE "@!S20" VALID (cInativo $ "SN")

     READ
 ENDIF

 IF LastKey() == 27
     RETURN NIL
 ENDIF

 SELECT PRODUTOS
 REPLACE NOME      WITH cNome
 REPLACE PRECO     WITH nPreco
 REPLACE CADASTRO  WITH dCadastro
 REPLACE INATIVO   WITH cInativo == "S"

 DBCOMMIT()

 MessageBox(, "Produto alterado com sucesso!", "Confirmação")

 lRetorno := .T.

 RETURN lRetorno
