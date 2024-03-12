#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPrintSetup.ch"
#INCLUDE "protheus.ch"

#Define PAD_LEFT	 0
#Define PAD_RIGHT	 1
#Define PAD_CENTER 2

/*/{Protheus.doc} IMPRESOP
description

@version 12.1.33 
@author Anderson Alberto
@author protheus
@since 12/03/2024
@return variant, return_description
/*/

User Function IMPRESOP()

	Local aParamBox := {}
	
   Private aRet    := {}

	AAdd(aParamBox,{9,"Impressao da ordem de producao",150,150,.T.})
	aAdd(aParamBox,{1,"Ordem de Producao" , Space(TamSX3("D3_OP")[1]) ,""  ,"","SC2" ,"",050,.F.})
	aAdd(aParamBox,{1,"Lote Programacao"  , Space(06)                 ,""  ,"",""    ,"",050,.F.})
	aAdd(aParamBox,{1,"Versao"            , Space(03)                 ,""  ,"",""    ,"",050,.F.})
	aAdd(aParamBox,{1,"Prog.Prd."         , Space(06)                 ,""  ,"",""    ,"",050,.F.})
	aAdd(aParamBox,{1,"Tarefa"            , Space(050)                ,""  ,"",""    ,"",050,.F.})
	aAdd(aParamBox,{1,"Primeira Camada"   , Space(200)                ,""  ,"","ACB" ,"",050,.F.})
	aAdd(aParamBox,{1,"Segunda Camada"    , Space(200)                ,""  ,"","ACB" ,"",050,.F.})
	aAdd(aParamBox,{1,"Terceira Camada"   , Space(200)                ,""  ,"","ACB" ,"",050,.F.})

	If !ParamBox(aParamBox,"Parâmetros...",@aRet,,,,,,,,.t.,.f.)
		Return
	EndIf

	lEnd := .F.
	Processa( {|lEnd| fImprime(@lEnd)},"Impressao da ordem de producao",,.T.)

Return

//-------------------------------------------------------------------
Static Function fImprime(lEnd)
//-------------------------------------------------------------------
	Local nCnt
	
   Private nLin	    := 10000
	Private m_pag    := 0
	Private cLogo    := "lgrl0101.bmp"
	Private cDirDocs := If(FindFunction("MsMultDir") .and. MsMultDir(), MsRetPath(), MsDocPath())

	SC2->(DbSetOrder(1))
	If !SC2->(DbSeek(xFilial("SC2")+aRet[2]))
		ApMsgInfo("Nao existem dados a serem processados!")
		Return
	EndIf

	oFnt06  := TFont():New("Arial",,06,,.F.,,,,.F.,.F.)
	oFnt06N := TFont():New("Arial",,06,,.T.,,,,.F.,.F.)
	oFnt08  := TFont():New("Arial",,08,,.F.,,,,.F.,.F.)
	oFnt08N := TFont():New("Arial",,08,,.T.,,,,.F.,.F.)
	oFnt10  := TFont():New("Arial",,10,,.F.,,,,.F.,.F.)
	oFnt10N := TFont():New("Arial",,10,,.T.,,,,.F.,.F.)
	oFnt12N := TFont():New("Arial",,12,,.T.,,,,.F.,.F.)
	oFnt14N := TFont():New("Arial",,14,,.T.,,,,.F.,.F.)

	oBrush1 := TBrush():New( ,CLR_HGRAY )
	oBrush2 := TBrush():New( ,CLR_GRAY )

	cFileCSV  := "ordem_producao_"+AllTrim(aRet[2])+"_"+DToS(Date())+"_"+StrTran(Time(),":","") //+".rel"
	cRootTemp  := "\temp\"
	lAdjustToLegacy := .t. // Inibe legado de resolução com a TMSPrinter
	lDisableSetup := .T.
	oPrn:=FWMSPrinter():New(cFileCSV, IMP_SPOOL, lAdjustToLegacy)//, cRootTemp /*cPathInServer*/, .F. /*lDisabeSetup*/,/*lTReport*/,/*@oPrintSetup*/,/*cPrinter*/,/*lServer*/,/*lPDFAsPNG*/, .F./*lRaw*/,.t./*lViewPDF*/,/*nQtdCopy*/)
	oPrn:SetPortrait()
	oPrn:SetPaperSize(DMPAPER_A4)

	nLinhas    := 3250
	nLimite    := 3000

	SC2->(DbSetOrder(1))
	SB1->(DbSetOrder(1))
	SD4->(DbSetOrder(2)) // D4_FILIAL+D4_OP+D4_COD+D4_LOCAL
	SG2->(DbSetOrder(1)) // G2_FILIAL+G2_PRODUTO+G2_CODIGO+G2_OPERAC
	SH6->(DbSetOrder(1)) // H6_FILIAL+H6_OP+H6_PRODUTO+H6_OPERAC+H6_SEQ+DTOS(H6_DATAINI)+H6_HORAINI+DTOS(H6_DATAFIN)+H6_HORAFIN
	ProcRegua(0)
	IncProc()

	//-------------------------------------------------------------------
	// Cabecalho
	//-------------------------------------------------------------------
	oPrn:StartPage()

	nLin:=10
	oPrn:SayBitmap(nLin, 0060, cLogo, 0200, 0200) //Impressao do Logotipo
	nLin+=60
	cTexto := AllTrim(SM0->M0_NOMECOM)
	nWidth1 := oPrn:GetTextWidth(cTexto,oFnt14N,1)
	oPrn:Say(nLin,(2300/2)-nWidth1/2,cTexto,oFnt14N)
	oPrn:Say(nLin,1800,"CNPJ : "+Transform(SM0->M0_CGC,"@R 99.999.999/9999-99"),oFnt14N)
	nLin+=60
	cTexto := "ORDEM DE FABRICACAO PERSONALISADA"
	nWidth1 := oPrn:GetTextWidth(cTexto,oFnt14N,1)
	oPrn:Say(nLin,(2300/2)-nWidth1/2,cTexto,oFnt14N)
	oPrn:Say(nLin,1800,"SEM DEFINICAO",oFnt14N)
	nLin+=60
	oPrn:Say(nLin,1800,"Data : "+DToC(Date())+" "+Time(),oFnt14N)
	nLin+=60
	oPrn:Line(nLin, 060, nLin, 2300, , "-4" )
	nLin+=20

	SC2->(DbSeek(xFilial("SC2")+aRet[2]))
	SB1->(DbSeek(xFilial("SB1")+SC2->C2_PRODUTO))
	nLin+=10

	//-------------------------------------------------------------------
	// Grid 1
	//-------------------------------------------------------------------
	oPrn:Say(nLin,0060,"Lote Programacao : "+aRet[3]             ,oFnt12N)
	oPrn:Say(nLin,0800,"Versao : "          +aRet[4]             ,oFnt12N)
	oPrn:Say(nLin,1100,"Roteiro : "         +SC2->C2_ROTEIRO     ,oFnt12N)
	oPrn:Say(nLin,1600,"Prog.Prd. : "       +aRet[5]             ,oFnt12N)
	oPrn:Say(nLin,1970,"Data Inicio : "     +DToC(SC2->C2_DATPRI),oFnt12N)
	nLin+=80

	//-------------------------------------------------------------------
	// Grid 2
	//-------------------------------------------------------------------
	oPrn:Code128(nLin-40, 0060, AllTrim(SB1->B1_CODBAR), 0.8, 20, .f., oFnt06)
	oPrn:Say(nLin+50,0090,AllTrim(SB1->B1_CODBAR)            ,oFnt08)
	oPrn:Say(nLin,0500,SB1->B1_DESC                          ,oFnt12N)
	oPrn:Say(nLin,1950,"Data Entrega : "+DToC(SC2->C2_DATPRF),oFnt12N)
	nLin+=80

	//-------------------------------------------------------------------
	// Grid 3
	//-------------------------------------------------------------------
	oPrn:Say(nLin,0060,"Lote : "      +SC2->C2_XLOTE                                   ,oFnt12N)
	oPrn:Say(nLin,0600,"Quantidade : "+Transf(SC2->C2_QUANT,PesqPict('SC2','C2_QUANT')),oFnt12N)
	oPrn:Say(nLin,1100,"U.M. : "      +SC2->C2_UM                                      ,oFnt12N)
	oPrn:Say(nLin,1600,"O.F. : "      +SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)                 ,oFnt12N)
	oPrn:Code128(nLin-40, 1900, AllTrim(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN)), 0.8, 20, .F., oFnt06)
	nLin+=80

	//-------------------------------------------------------------------
	// Grid 4
	//-------------------------------------------------------------------
	nLinBox := 60
	oPrn:Box ( nLin ,0060, nLin+nLinBox, 2300 )
	cTitulo := "Operacoes"
	nWidth1 := oPrn:GetTextWidth(cTitulo,oFnt10N,1)
	oPrn:Say(nLin+30,(2300/2)-nWidth1/2,cTitulo,oFnt10N)
	nLin+=nLinBox
	oPrn:Box (nLin,0060, nLin+nLinBox, 0350 )
	oPrn:Box (nLin,0350, nLin+nLinBox, 1200 )
	oPrn:Box (nLin,1200, nLin+nLinBox, 1500 )
	oPrn:Box (nLin,1500, nLin+nLinBox, 2300 )

	oPrn:Say(nLin+30,0070,"Operacao" ,oFnt10N)
	oPrn:Say(nLin+30,0360,"Tarefa"   ,oFnt10N)
	oPrn:Say(nLin+30,1210,"Maquina"  ,oFnt10N)
	oPrn:Say(nLin+30,1510,"Descricao",oFnt10N)
	nLin+=nLinBox

	SG2->(DbSeek(xFilial("SG2")+SC2->(C2_PRODUTO+C2_ROTEIRO)))
	While !SG2->(EoF()) .And.;
			SG2->G2_FILIAL == xFilial("SG2") .And.;
			SG2->G2_PRODUTO == SC2->C2_PRODUTO .And.;
			SG2->G2_CODIGO == SC2->C2_ROTEIRO
		oPrn:Box (nLin,0060, nLin+(nLinBox*2), 0350 )
		oPrn:Box (nLin,0350, nLin+(nLinBox*2), 1200 )
		oPrn:Box (nLin,1200, nLin+(nLinBox*2), 1500 )
		oPrn:Box (nLin,1500, nLin+(nLinBox*2), 2300 )

		oPrn:Code128(nLin+10, 0090, AllTrim(SG2->G2_OPERAC), 0.8, 20, .f., oFnt06)
		oPrn:Say(nLin+100,0100,SG2->G2_OPERAC ,oFnt08)
		oPrn:Say(nLin+60,0360,aRet[6]        ,oFnt10N)
		oPrn:Say(nLin+60,1210,SG2->G2_RECURSO,oFnt10N)
		oPrn:Say(nLin+60,1510,SG2->G2_DESCRI ,oFnt10N)
		nLin+=(nLinBox*2)
		SG2->(DbSkip())
	End
	nLin+=60

	//-------------------------------------------------------------------
	// Grid 5
	//-------------------------------------------------------------------
	oPrn:Box ( nLin , 060, nLin+nLinBox, 2300 )
	cTitulo := "Componentes"
	nWidth1 := oPrn:GetTextWidth(cTitulo,oFnt10N,1)
	oPrn:Say(nLin+30,(2300/2)-nWidth1/2,cTitulo,oFnt10N)
	nLin+=nLinBox
	oPrn:Box (nLin,0060, nLin+nLinBox, 0500 )
	oPrn:Box (nLin,0500, nLin+nLinBox, 1200 )
	oPrn:Box (nLin,1200, nLin+nLinBox, 1300 )
	oPrn:Box (nLin,1300, nLin+nLinBox, 1500 )
	oPrn:Box (nLin,1500, nLin+nLinBox, 1800 )
	oPrn:Box (nLin,1800, nLin+nLinBox, 2100 )
	oPrn:Box (nLin,2100, nLin+nLinBox, 2300 )

	oPrn:Say(nLin+30,0070,"Componente",oFnt10N)
	oPrn:Say(nLin+30,0510,"Descricao" ,oFnt10N)
	oPrn:Say(nLin+30,1210,"UM"        ,oFnt10N)
	oPrn:Say(nLin+30,1310,"Sugerido"  ,oFnt10N)
	oPrn:Say(nLin+30,1510,"Retirado"  ,oFnt10N)
	oPrn:Say(nLin+30,1810,"R.I.R."    ,oFnt10N)
	oPrn:Say(nLin+30,2110,"Lote"      ,oFnt10N)
	nLin+=nLinBox

	SD4->(DbSeek(xFilial("SD4")+PadR(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN),TamSX3("D4_OP")[1])))
	While !SD4->(EoF()) .And.;
			SD4->D4_FILIAL == xFilial("SC2") .And.;
			SD4->D4_OP == PadR(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN),TamSX3("D4_OP")[1])
		SB1->(DbSeek(xFilial("SB1")+SD4->D4_COD))

		oPrn:Box (nLin,0060, nLin+(nLinBox*2), 0500 )
		oPrn:Box (nLin,0500, nLin+(nLinBox*2), 1200 )
		oPrn:Box (nLin,1200, nLin+(nLinBox*2), 1300 )
		oPrn:Box (nLin,1300, nLin+(nLinBox*2), 1500 )
		oPrn:Box (nLin,1500, nLin+(nLinBox*2), 1800 )
		oPrn:Box (nLin,1800, nLin+(nLinBox*2), 2100 )
		oPrn:Box (nLin,2100, nLin+(nLinBox*2), 2300 )

		oPrn:Code128(nLin+10, 0090, AllTrim(SB1->B1_CODBAR), 0.8, 20, .f., oFnt06)
		oPrn:Say(nLin+100,0100,AllTrim(SB1->B1_CODBAR)                          ,oFnt08)
		oPrn:Say(nLin+60,0510,SB1->('('+AllTrim(B1_COD)+')-'+AllTrim(B1_DESC)) ,oFnt10N)
		oPrn:Say(nLin+60,1210,SB1->B1_UM                                       ,oFnt10N)
		oPrn:Say(nLin+60,1310,Transf(SD4->D4_QUANT,PesqPict('SD4','D4_QUANT')) ,oFnt10N)
		oPrn:Say(nLin+60,1510,""                                               ,oFnt10N)
		oPrn:Say(nLin+60,1810,""                                               ,oFnt10N)
		oPrn:Say(nLin+60,2110,SD4->D4_LOTECTL                                  ,oFnt10N)
		nLin+=(nLinBox*2)
		SD4->(DbSkip())
	End
	nLin+=60

	//-------------------------------------------------------------------
	// Grid 6
	//-------------------------------------------------------------------
	oPrn:Box ( nLin , 060, nLin+nLinBox, 2300 )
	cTitulo := "Apontamentos"
	nWidth1 := oPrn:GetTextWidth(cTitulo,oFnt10N,1)
	oPrn:Say(nLin+30,(2300/2)-nWidth1/2,cTitulo,oFnt10N)
	nLin+=nLinBox
	oPrn:Box (nLin,0060, nLin+nLinBox, 0350 )
	oPrn:Box (nLin,0350, nLin+nLinBox, 0640 )
	oPrn:Box (nLin,0640, nLin+nLinBox, 0930 )
	oPrn:Box (nLin,0930, nLin+nLinBox, 1220 )
	oPrn:Box (nLin,1220, nLin+nLinBox, 1510 )
	oPrn:Box (nLin,1510, nLin+nLinBox, 1800 )
	oPrn:Box (nLin,1800, nLin+nLinBox, 2090 )
	oPrn:Box (nLin,2090, nLin+nLinBox, 2300 )

	oPrn:Say(nLin+30,0070,"Data" ,oFnt10N)
	oPrn:Say(nLin+30,0360,"Qtde" ,oFnt10N)
	oPrn:Say(nLin+30,0650,"Data" ,oFnt10N)
	oPrn:Say(nLin+30,0940,"Qtde" ,oFnt10N)
	oPrn:Say(nLin+30,1230,"Data" ,oFnt10N)
	oPrn:Say(nLin+30,1520,"Qtde" ,oFnt10N)
	oPrn:Say(nLin+30,1810,"Data" ,oFnt10N)
	oPrn:Say(nLin+30,2100,"Qtde" ,oFnt10N)
	nLin+=nLinBox

	SH6->(DbSetOrder(1)) // H6_FILIAL+H6_OP+H6_PRODUTO+H6_OPERAC+H6_SEQ+DTOS(H6_DATAINI)+H6_HORAINI+DTOS(H6_DATAFIN)+H6_HORAFIN
	aApontamentos := {}
	SH6->(DbSeek(xFilial("SH6")+PadR(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN),TamSX3("H6_OP")[1])))
	While !SH6->(EoF()) .And.;
			SH6->H6_FILIAL == xFilial("SC2") .And.;
			SH6->H6_OP == PadR(SC2->(C2_NUM+C2_ITEM+C2_SEQUEN),TamSX3("H6_OP")[1])

		If (nElem:=AScan(aApontamentos,{|x|x[1]==SToD(SH6->H6_DTAPONT)})) == 0
			AAdd( aApontamentos , {SToD(SH6->H6_DTAPONT),0} )
			nElem := Len(aApontamentos)
		EndIf
		aApontamentos[nElem][2] += SH6->H6_QTDPROD
		SH6->(DbSkip())
	End

	aApontamentos := ASort( aApontamentos ,,, {|x,y| x[1] < y[1]} )

	nPos := 0
	For nCnt := 1 To Len(aApontamentos)
		If nPos == 0
			oPrn:Box (nLin,0060, nLin+nLinBox, 0350 )
			oPrn:Box (nLin,0350, nLin+nLinBox, 0640 )
			oPrn:Box (nLin,0640, nLin+nLinBox, 0930 )
			oPrn:Box (nLin,0930, nLin+nLinBox, 1220 )
			oPrn:Box (nLin,1220, nLin+nLinBox, 1510 )
			oPrn:Box (nLin,1510, nLin+nLinBox, 1800 )
			oPrn:Box (nLin,1800, nLin+nLinBox, 2090 )
			oPrn:Box (nLin,2090, nLin+nLinBox, 2300 )
		EndIf
		nPos++
		If nPos == 1
			nCol1 := 0070
			nCol2 := 0360
		ElseIf nPos == 2
			nCol1 := 0650
			nCol2 := 0940
		ElseIf nPos == 3
			nCol1 := 1230
			nCol2 := 1520
		ElseIf nPos == 4
			nCol1 := 1810
			nCol2 := 2100
		EndIf
		oPrn:Say(nLin+30,nCol1,SToD(aApontamentos[nCnt][1]) ,oFnt10N)
		oPrn:Say(nLin+30,nCol2,Transf(aApontamentos[nCnt][2],PesqPict('SH6','H6_QTDPROD')) ,oFnt10N)
		If nPos == 4
			nPos := 0
			nLin+=(nLinBox*2)
		EndIf
	Next nCnt
	If Len(aApontamentos) == 0
		oPrn:Box (nLin,0060, nLin+nLinBox, 0350 )
		oPrn:Box (nLin,0350, nLin+nLinBox, 0640 )
		oPrn:Box (nLin,0640, nLin+nLinBox, 0930 )
		oPrn:Box (nLin,0930, nLin+nLinBox, 1220 )
		oPrn:Box (nLin,1220, nLin+nLinBox, 1510 )
		oPrn:Box (nLin,1510, nLin+nLinBox, 1800 )
		oPrn:Box (nLin,1800, nLin+nLinBox, 2090 )
		oPrn:Box (nLin,2090, nLin+nLinBox, 2300 )
		nLin+=(nLinBox*2)
	EndIf
	nLin+=60

	//-------------------------------------------------------------------
	// Impressao das imagens das camadas
	//-------------------------------------------------------------------
	oPrn:Say(nLin,0650,"Primeira Camada",oFnt08)
	oPrn:SayBitmap(nLin+10, 0550, cDirDocs+"\"+AllTrim(aRet[7]), 0400, 0400)

	oPrn:Say(nLin,1150,"Segunda Camada",oFnt08)
	oPrn:SayBitmap(nLin+10, 1050, cDirDocs+"\"+AllTrim(aRet[8]), 0400, 0400)

	oPrn:Say(nLin,1650,"Terceira Camada",oFnt08)
	oPrn:SayBitmap(nLin+10, 1550, cDirDocs+"\"+AllTrim(aRet[9]), 0400, 0400)

	oPrn:EndPage()

	oPrn:Preview()

Return
