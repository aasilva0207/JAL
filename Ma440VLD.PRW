#include 'totvs.ch'

/*/{Protheus.doc} Ma440VLD
Ma440VLD - Valida豫o na libera豫o do pedido de vendas ( ) --> lRet

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function Ma440VLD()

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Declaracao de Variaveis                                                                     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
    Local lReturn   := .T.

    If SC5->C5_BLQ == '3'
        lReturn := !lReturn
        MsgInfo( 'Bloqueio - LUCRATIVIDADE E COMISS홒', 'Aten豫o!' )
    Endif

Return ( lReturn )
