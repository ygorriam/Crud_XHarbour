#INCLUDE "WINUSER.CH"

*-----------------*
 FUNCTION EXCLUIR()

IF PRODUTOS->CODIGO == 0
    MessageBox("Não há produtos cadastrados para excluir.", "Atenção")
    RETURN NIL
ENDIF

 IF MessageBox(,"Deseja realmente excluir o produto?","Atenção",MB_ICONQUESTION+MB_YESNO)==IDNO
    RETURN NIL
 ENDIF

 SELECT PRODUTOS
 RLock()
 DELETE
 DBUnlockALL()
 RETURN NIL