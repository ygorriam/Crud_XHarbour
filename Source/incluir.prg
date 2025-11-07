#INCLUDE "WINUSER.CH"

*-----------------*
 FUNCTION INCLUIR()

LOCAL nCodigo := 0
LOCAL cNome := SPACE(50)
LOCAL nPreco := 0.00
LOCAL dCadastro := Date()
LOCAL cInativo := "N"
LOCAL lRetorno := .F.

DBSelectArea("PRODUTOS")

 @ 02,00 SAY PadC("INCLUSAO", 80)
 @ 03,00 SAY Replicate("-", 80)
 @ 04,10 SAY "CODIGO:          " GET nCodigo  PICTURE "99999"
 @ 05,10 SAY "NOME:            " GET cNome    PICTURE "@!"
 @ 06,10 SAY "PRECO:           " GET nPreco    PICTURE "999.99"
 @ 07,10 SAY "CADASTRO:        " GET dCadastro
 @ 08,10 SAY "INATIVO:         " GET cInativo PICTURE "@!"

 READ

 IF LastKey()==27
   RETURN NIL
ENDIF

*-----------------------------------------*
* Validações
*-----------------------------------------*
IF nCodigo <= 0
   MessageBox("Código deve ser maior que zero!", "Atenção")
   RETURN NIL
ENDIF

IF DBSEEK(nCodigo)
   MessageBox("Código já existe!", "Atenção")
   RETURN NIL
ENDIF

IF nPreco <= 0
   MessageBox("Preço deve ser maior que zero!", "Atenção")
   RETURN NIL
ENDIF

IF dCadastro < Date()
   MessageBox("Data de cadastro não pode ser menor que a data atual!", "Atenção")
   RETURN NIL
ENDIF

IF !(cInativo$"SN")
   MessageBox("Campo INATIVO deve ser S ou N!", "Atenção")
   RETURN NIL
ENDIF

*-----------------------------------------*
* Grava no banco
*-----------------------------------------*
DBAPPEND()
REPLACE CODIGO    WITH nCodigo
REPLACE NOME      WITH cNome
REPLACE PRECO     WITH nPreco
REPLACE CADASTRO  WITH dCadastro
REPLACE INATIVO   WITH cInativo

DBCOMMIT()

MessageBox("Produto incluído com sucesso!", "Confirmação")

lRetorno := .T.

RETURN lRetorno
