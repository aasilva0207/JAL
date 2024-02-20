#include 'totvs.ch'
//Constantes
#Define STR_PULA		Chr(13)+Chr(10)

/*/{Protheus.doc} MTA040MNU
O ponto de entrada MTA040MNU pemirtirА inserir novas opГУes personalizadas no array aRotina do cadastro de vendedores.

@version 12.1.33 
@author Anderson Alberto
@author protheus
@since 19/02/2024
@return variant, return_description
/*/

User Function MTA040MNU()

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё InclusЦo da Rotina de UPDATE da SE3                                                         Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	aadd(aRotina, {'UPDATE DA COMISSцO','U_UPDSE3' , 0 , 3,0,NIL})

Return

/*/{Protheus.doc} UPDSE3
description

@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

User Function UPDSE3()

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Declaracao de Variaveis                                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	Local aArea   := GetArea()

	Private cPerg := 'UPDSE3  '

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Valida se existe Pergunta                                                                   Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	ValidPerg()
	If !Pergunte(cPerg, .T.)
		Return .F.
	EndIf

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Se a pergunta nЦo existir, zera a variАvel                                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	DbSelectArea('SX1')
	SX1->(DbSetOrder(1)) //X1_GRUPO + X1_ORDEM
	If !SX1->(DbSeek(cPerg))
		cPerg := Nil
	EndIf

	Processa({|| FUPDSE3()}, 'Processando AtualizaГЦo da ComissЦo...')

	RestArea(aArea)

Return

/*/{Protheus.doc} FUPDSE3
FunГЦo que efetiva atualizaГЦo da comissЦo na Tabela SE3

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

Static Function FUPDSE3()

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Declaracao de Variaveis                                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	Local cQuery := ''

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё ConfirmaГЦo e AtualizaГЦo de registros conforme parametros                                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	If MsgYesNo('O sistema atualizarА COMISSAO dos VENDEDORES,' + MV_PAR01 + ' atИ ' + MV_PAR02 + '. Deseja confirmar?', 'Confirma alteraГЦo?')
		cQuery	:= " UPDATE " + RetSQLName('SE3') +" SET "
		cQuery	+= "  E3_XVALANT = E3_COMIS "
		cQuery	+= " ,E3_XVLCOMI = (E3_BASE * E3_XPERBON) / 100 "
		cQuery	+= " ,E3_COMIS	= E3_XVALANT + E3_XVLCOMI "
		cQuery	+= " ,E3_XUSUARI	= '"+ Padr(PswChave(RetCodUsr()), 10) +"'"
		cQuery	+= " ,E3_XDATA	= '"+ dToc(date()) + '-' + Time() +"'"
		cQuery	+= " WHERE E3_VEND BETWEEN '" + MV_PAR01 +"' AND '"+ MV_PAR02 + "' AND D_E_L_E_T_ = ' ' "
		TCSQLEXEC(cQuery)
		MsgInfo('COMISSцO ATUALIZADA.')
	EndIf

Return

/*/{Protheus.doc} ValidPerg
CriaГЦo das Perguntas conforme chamada

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/02/2024
@return variant, return_description
/*/

Static Function VALIDPERG()

	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Declaracao de Variaveis                                                                     Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	Local _sAlias   := Alias()
	Local i         := 0
	Local j         := 0


	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё CriaГЦo de Perguntas                                                                        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
	dbSelectArea('SX1')
	dbSetOrder(1)
	aRegs:={}
	cPerg := if(upper(substr(cVersao, 1, 3)) == 'MP8',padr(cPerg,6),padr(cPerg,10))
	aadd(aRegs,{cPerg,'01','Vend De?'		,'Espanhol','Ingles','mv_ch1','C',6,0,0,'G','','mv_par01','','','','','','','','','','','','','','','','','','','','','','','','','SA3',''})
	aadd(aRegs,{cPerg,'02','Vend AtИ?'		,'Espanhol','Ingles','mv_ch2','C',6,0,0,'G','','mv_par02','','','','','','','','','','','','','','','','','','','','','','','','','SA3',''})


	//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Confirma criaГЦo das Perguntas                                                              Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддюддддддддддддддддддддддды
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
