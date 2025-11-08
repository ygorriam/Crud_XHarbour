#INCLUDE "WINUSER.CH"
#INCLUDE "FILEIO.CH"

*-----------------*
FUNCTION IMPRIMIR()

LOCAL nArquivo
LOCAL lRetorno  := .F.
LOCAL cCRLF     := Chr(13) + Chr(10)

SELECT PRODUTOS


IF PRODUTOS->CODIGO==0
    MessageBox(,"Não há produtos cadastrados.","Atenção",MB_ICONWARNING)
    RETURN NIL
 ENDIF


nArquivo := FCreate("Relatório.txt", 0)


IF nArquivo < 0
    MessageBox("Erro ao criar o arquivo Relatorio.txt! Verifique permissões.", "Erro")
    RETURN NIL
ENDIF


FWRITE(nArquivo, PadC("RELATÓRIO DE PRODUTOS", 80) + cCRLF)
FWRITE(nArquivo, Replicate("=", 80) + cCRLF)


FWRITE(nArquivo, "CÓD. | NOME" + Space(40) + " | PREÇO | CADASTRO | INATIVO" + cCRLF)
FWRITE(nArquivo, Replicate("-", 80) + cCRLF)

DBGoTop()

DO WHILE ! Eof()

    FWRITE(nArquivo,;
              Transform(CODIGO, "9999") + " | " +;
              PadR(NOME, 43) + " | " +;
              Transform(PRECO, "@E 999.99") + " | " +;
              DToC(CADASTRO) + " | " +;
              IIf(INATIVO, "Sim", "Não") + cCRLF)

    DBSKIP()
ENDDO


FWRITE(nArquivo, Replicate("=", 80) + cCRLF)

FCLOSE(nArquivo)


MessageBox("Relatório.txt gerado com sucesso!", "Relatório", MB_ICONINFORMATION)

lRetorno := .T.
RETURN lRetorno