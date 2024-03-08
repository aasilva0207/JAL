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
	Local nDescont	:= 0

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida soma dos descontos por item                                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea('TMP1')
	dbGotop()
	While !TMP1->(Eof()) //.And. SCJ->CJ_FILIAL+SCJ->CJ_NUM == TMP1->CK_FILENT+TMP1->CK_NUM

		nDescont	+= TMP1->CK_DESCON

		TMP1->(dbSkip())
	EndDo

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualiza o campo de controle para bloqueio                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If ( nDescont >= 10 .And. nDescont <= 20 ) .Or. ( SCJ->CJ_DESCONT >= 10 .And. SCJ->CJ_DESCONT <= 20 )
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISSÃO - GERENTE', 'Atenção!' )
		M->CJ_XSTATUS := '0'
	ElseIf nDescont >= 20 .Or. SCJ->CJ_DESCONT >= 20
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISSÃO - DIRETOR', 'Atenção!' )
		M->CJ_XSTATUS := '1'
	Else
		M->CJ_XSTATUS := ' '
	Endif

	RestArea(aAreaSCJ)

Return ( lRet )
