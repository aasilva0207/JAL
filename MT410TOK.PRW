#include 'totvs.ch'

/*/{Protheus.doc} MT410TOK
MT410TOK - Validar confirma豫o da opera豫o

@type function
@version  
@author protheus
@since 15/01/2024
@return variant, return_description
/*/

User Function MT410TOK()

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Declaracao de Variaveis                                                                     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	Local lRet		:= .T.
	Local aAreaSC5  := SC5->(GetArea())
	Local nDescont	:= 0
	Local nLoop		:= 0


	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Valida soma dos descontos por item                                                          �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	For nLoop := 1 To Len(aCols)
		nDescont    := aCols[nLoop, GdFieldPos('C6_DESCONT')]
	Next nLoop

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Atualiza o campo de controle para bloqueio                                                  �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	If nDescont > 10 .Or. M->C5_DESCONT > 10
		M->C5_BLQ := '3'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISS홒 - GERENTE', 'Aten豫o!' )
	ElseIf nDescont > 20 .Or. M->C5_DESCONT > 20
		M->C5_BLQ := '3'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISS홒 - DIRETOR', 'Aten豫o!' )
	Endif

	RestArea(aAreaSC5)

Return ( lRet )
