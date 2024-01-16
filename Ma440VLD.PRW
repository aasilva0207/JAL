#include 'totvs.ch'

/*/{Protheus.doc} Ma440VLD
Ma440VLD - Validação na liberação do pedido de vendas ( ) --> lRet

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function Ma440VLD()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    Local lReturn   := .T.

    If SC5->C5_BLQ == '3'
        lReturn := !lReturn
        MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISSÃO', 'Atenção!' )
    Endif

Return ( lReturn )
