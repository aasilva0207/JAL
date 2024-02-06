#include 'totvs.ch'

/*/{Protheus.doc} MT410TOK
MT410TOK - Validar confirma��o da opera��o

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function MT410TOK()

	//���������������������������������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                                                     �
	//�����������������������������������������������������������������������������������������������
	Local lRet		:= .T.
	Local aAreaSC5  := SC5->(GetArea())
	Local nDescont	:= 0
	Local nLoop		:= 0

	//���������������������������������������������������������������������������������������������Ŀ
	//� Valida soma dos descontos por item                                                          �
	//�����������������������������������������������������������������������������������������������
	For nLoop := 1 To Len(aCols)
		nDescont	:= aCols[nLoop, GdFieldPos('C6_DESCONT')]
	Next nLoop

	//���������������������������������������������������������������������������������������������Ŀ
	//� Atualiza o campo de controle para bloqueio                                                  �
	//�����������������������������������������������������������������������������������������������
	If ( nDescont >= 10 .And. nDescont <= 20 ) .Or. ( M->C5_DESCONT >= 10 .And. M->C5_DESCONT <= 20 )
		M->C5_XBLQ := '3'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISS�O - GERENTE', 'Aten��o!' )
	ElseIf nDescont > 20 .Or. M->C5_DESCONT > 20
		M->C5_XBLQ := '4'
		MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISS�O - DIRETOR', 'Aten��o!' )
	Else
		M->C5_XBLQ := ''
	Endif

	RestArea(aAreaSC5)

Return ( lRet )