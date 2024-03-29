#include 'totvs.ch'

/*/{Protheus.doc} MA410LEG
MA410LEG - Alterar textos da legenda de status do pedido 

@type function
@version 12.1.33
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function MA410LEG()

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Declaracao de Variaveis                                                                     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	Local aLeg := PARAMIXB

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Atualiza豫o de novas legendas de                                                            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	aLeg := {   {'ENABLE'       ,'Pedido de Venda em aberto'                },;
                {'DISABLE'      ,'Pedido de Venda encerrado'                },;
                {'BR_AMARELO'   ,'Pedido de Venda liberado'                 },;
                {'BR_AZUL'      ,'Pedido de Venda com Bloqueio de Regra'    },;
                {'BR_LARANJA'   ,'Pedido de Venda com Bloqueio de Verba'    },;
                {'BR_PRETO'     ,'LUCRATIVIDADE E COMISS홒'                 } }//Customiza豫o

Return ( aLeg )
