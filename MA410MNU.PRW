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
	 aAdd(aRotina, {'APROVAÇÃO JAL', 'U_UPDSC5', 0, 3, 0, NIL })

Return( Nil)

/*/{Protheus.doc} UPDSC5
Atualiza SC5 conforme aprovação

@type function
@version 12.1.33 
@author Anderson Alberto
@since 20/02/2024
@return variant, return_description
/*/

User Function UPDSC5()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Valida Usuario para Atualizar SC5                                                           ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If RetCodUsr() $ GetNewPar('AJ_APROVA', '000000')
		RecLock('SC5', .F.)
		SC5->C5_XBLQ	:= ''
		SC5->(MsUnlock())
		Msginfo( 'Pedido Aprovado ', 'Atenção' )
	Else
		Msginfo( 'Rotina Utilizada Apenas por Gerentes e Diretores ', 'Atenção' )
	Endif

Return( Nil )
