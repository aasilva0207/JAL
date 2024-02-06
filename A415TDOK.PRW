#include 'totvs.ch'

/*/{Protheus.doc} A415TDOK
Ponto-de-Entrada: A415TDOK - Validação da tudook

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/01/2024
@return variant, return_description
/*/

User function A415TDOK()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    Local aAreaSCJ  := SCJ->(GetArea())
	Local lRet      := .T.                  // Variável utilizada para controle e validação ao clicar no botão SALVAR do Orçamento de venda
	Local nDescont  := M->CJ_DESCONT

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida soma dos descontos por item                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea('TMP1')
	dbGotop()
	While !TMP1->(Eof()) .And. M->CJ_FILIAL+M->CJ_NUM == TMP1->CK_FILIAL+TMP1->CK_NUM
		nDescont	+= TMP1->CK_DESCONT
		TMP1->(dbSkip())
	EndDo
	TMP1->(dbCloseArea())

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o campo de controle para bloqueio                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( nDescont >= 10 .And. nDescont <= 20 ) .Or. ( M->C5_DESCONT >= 10 .And. M->C5_DESCONT <= 20 )
		M->CJ_STATUS := '0'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISSÃO - GERENTE', 'Atenção!' )
	ElseIf nDescont > 20 .Or. M->C5_DESCONT > 20
		M->CJ_STATUS := '1'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISSÃO - DIRETOR', 'Atenção!' )
	Else
		M->CJ_STATUS := M->CJ_STATUS
	Endif

	RestArea(aAreaSCJ)

Return ( lRet )
