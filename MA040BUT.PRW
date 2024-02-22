#include 'totvs.ch'
//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} MTA040MNU
O ponto de entrada MTA040MNU pemirtirá inserir novas opções personalizadas no array aRotina do cadastro de vendedores.

@version 12.1.33 
@author Anderson Alberto
@author protheus
@since 19/02/2024
@return variant, return_description
/*/

User Function MTA040MNU()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclusão da Rotina de UPDATE da SE3                                                         ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aadd(aRotina, {'UPDATE DA COMISSÃO','U_UPDSE3' , 0 , 3,0,NIL})

Return

/*/{Protheus.doc} UPDSE3
description

@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

User Function UPDSE3()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aArea   := GetArea()

	Private cPerg := 'UPDSE3  '

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida se existe Pergunta                                                                   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	ValidPerg()
	If !Pergunte(cPerg, .T.)
		Return .F.
	EndIf

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Se a pergunta não existir, zera a variável                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DbSelectArea('SX1')
	SX1->(DbSetOrder(1)) //X1_GRUPO + X1_ORDEM
	If !SX1->(DbSeek(cPerg))
		cPerg := Nil
	EndIf

	Processa({|| FUPDSE3()}, 'Processando Atualização da Comissão...')

	RestArea(aArea)

Return

/*/{Protheus.doc} FUPDSE3
Função que efetiva atualização da comissão na Tabela SE3

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

Static Function FUPDSE3()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local cQuery := ''

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Confirmação e Atualização de registros conforme parametros                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If MsgYesNo('O sistema atualizará COMISSAO dos VENDEDORES,' + MV_PAR01 + ' até ' + MV_PAR02 + '. Deseja confirmar?', 'Confirma alteração?')
		cQuery	:= " UPDATE " + RetSQLName('SE3') +" SET "
		cQuery	+= "  E3_XVALANT = E3_COMIS "
		cQuery	+= " ,E3_XPERBON = "+ Alltrim(sTr(MV_PAR03)) +""
		cQuery	+= " ,E3_XVLCOMI = (E3_BASE * "+ Alltrim(sTr(MV_PAR03)) +") / 100 "
		cQuery	+= " ,E3_COMIS	= E3_XVALANT + E3_XVLCOMI "
		cQuery	+= " ,E3_XUSUARI	= '"+ Padr(PswChave(RetCodUsr()), 10) +"'"
		cQuery	+= " ,E3_XDATA	= '"+ dToc(date()) + '-' + Time() +"'"
		cQuery	+= " WHERE E3_VEND BETWEEN '" + MV_PAR01 +"' AND '"+ MV_PAR02 + "' AND D_E_L_E_T_ = ' ' "
		TCSQLEXEC(cQuery)
		MsgInfo('COMISSÃO ATUALIZADA.')
	EndIf

Return

/*/{Protheus.doc} ValidPerg
Criação das Perguntas conforme chamada

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

Static Function VALIDPERG()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local _sAlias   := Alias()
	Local i         := 0
	Local j         := 0


	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criação de Perguntas                                                                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	dbSelectArea('SX1')
	dbSetOrder(1)
	aRegs:={}
	cPerg := if(upper(substr(cVersao, 1, 3)) == 'MP8',padr(cPerg,6),padr(cPerg,10))
	aadd(aRegs,{cPerg,'01','Vend De?'		,'Espanhol','Ingles','mv_ch1','C',6,0,0,'G','','mv_par01','','','','','','','','','','','','','','','','','','','','','','','','','SA3',''})
	aadd(aRegs,{cPerg,'02','Vend Até?'		,'Espanhol','Ingles','mv_ch2','C',6,0,0,'G','','mv_par02','','','','','','','','','','','','','','','','','','','','','','','','','SA3',''})
	aadd(aRegs,{cPerg,'03','Porcentagem'	,'Espanhol','Ingles','mv_ch3','N',2,0,0,'G','','mv_par03','','','','','','','','','','','','','','','','','','','','','','','','','',''})

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Confirma criação das Perguntas                                                              ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	For i := 1 to Len(aRegs)
		If !dbSeek(cPerg+aRegs[i,2])
			RecLock('SX1',.T.)
			For j := 1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next j
			MsUnlock()
			dbCommit()
		EndIf
	Next i

	dbSelectArea(_sAlias)

Return
