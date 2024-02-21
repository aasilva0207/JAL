#include 'totvs.ch'

/*/{Protheus.doc} MA410MNU
SERVE P/INCLUIR BOTOES NA ENCHOICEBAR
É chamada no momento de montar a enchoicebar do pedido de vendas, e serve para incluir mais botões com rotinas de usuário.

@type function
@version 12.1.33 
@author Anderson Alberto
@since 20/02/2024
@return variant, return_description
/*/

User Function MA410MNU()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclusão de nova Rotina                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd(aRotina, {'APROVAÇÃO JAL', 'U_GETINFO', 0, 3, 0, NIL })

Return( Nil)

/*/{Protheus.doc} GETINFO
Atualiza SC5 conforme aprovação

@type function
@version 12.1.33 
@author Anderson Alberto
@since 20/02/2024
@return variant, return_description
/*/

User Function GETINFO()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaração de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Private oDlgPvt	:= Nil
	Private oGrpFor	:= Nil
	Private oGetFor	:= Nil
	Private oGrpAco	:= Nil
	Private oBtnExe	:= Nil
	Private cGetInfo := Space(250)
	Private nJanLarg:= 500
	Private nJanAltu:= 120
	Private nJanMeio:= ((nJanLarg)/2)/2
	Private nTamBtn := 048

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Criando Janela			                                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE MSDIALOG oDlgPvt TITLE 'DADOS DE APROVAÇÃO' FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
	@ 003, 003  GROUP oGrpFor TO 30, (nJanLarg/2)-1        PROMPT 'MENSAGEM: ' OF oDlgPvt COLOR 0, 16777215 PIXEL
	@ 010, 006  MSGET oGetFor VAR cGetInfo SIZE (nJanLarg/2)-9, 013 OF oDlgPvt COLORS 0, 16777215 PIXEL
	oGetFor:cPlaceHold := 'Insira o mensagem de Aprovação...'

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Grupo Ações com o Botão	                                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ (nJanAltu/2)-30, 003 GROUP oGrpAco TO (nJanAltu/2)-3, (nJanLarg/2)-1 PROMPT 'Ações: ' OF oDlgPvt COLOR 0, 16777215 PIXEL
	@ (nJanAltu/2)-24, nJanMeio - (nTamBtn/2) BUTTON oBtnExe PROMPT 'CONFIRMAR' SIZE nTamBtn, 018 OF oDlgPvt Action(oDlgPvt:End(), UPDSC5()) PIXEL
         
    //Ativando a janela
    ACTIVATE MSDIALOG oDlgPvt CENTERED

Return( Nil )
 
/*/{Protheus.doc} UPDSC5
Atualiza dados na SC5

@type function
@version 12.1.33 
@author Anderson Alberto
@since 21/02/2024
@return variant, return_description
/*/ 

Static Function UPDSC5()
 
 	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Usuario para Atualizar SC5                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If RetCodUsr() $ GetNewPar('AJ_APROVA', '000000')
		RecLock('SC5', .F.)
		SC5->C5_XBLQ	:= ''
		SC5->C5_XBLQMEN	:= cGetInfo
		SC5->(MsUnlock())
		Msginfo( 'Pedido Aprovado ', 'Atenção' )
	Else
		Msginfo( 'Rotina Utilizada Apenas por Gerentes e Diretores ', 'Atenção' )
	Endif

Return( Nil )
