#INCLUDE "WINUSER.CH"


FUNCTION BUSCAR()

LOCAL cBusca := SPACE(30)
LOCAL lAchou := .F.

SELECT PRODUTOS


IF PRODUTOS->CODIGO==0
    MessageBox("Não há produtos cadastrados para buscar.", "Atenção")
    RETURN NIL
ENDIF


@ 05,25 CLEAR TO 08,55
@ 05,30 SAY "BUSCAR PRODUTO (NOME):"
@ 06,30 GET cBusca PICTURE "@!"

READ

IF LastKey() == 27
    RETURN NIL
ENDIF

IF DBSEEK(cBusca)
    lAchou := .T.

ELSE
    MessageBox(,"Produto " +cBusca+"não foi encontrado!",MB_ICONWARNING)


ENDIF

@ 05,25 CLEAR TO 08,55

RETURN lAchou