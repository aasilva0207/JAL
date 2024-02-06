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

	//���������������������������������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                                                     �
	//�����������������������������������������������������������������������������������������������
	Local aLeg := PARAMIXB

	//���������������������������������������������������������������������������������������������Ŀ
	//� Atualiza��o de novas legendas de                                                            �
	//�����������������������������������������������������������������������������������������������
	aLeg := {   {'ENABLE'       ,'Pedido de Venda em aberto'                },;
                {'DISABLE'      ,'Pedido de Venda encerrado'                },;
                {'BR_AMARELO'   ,'Pedido de Venda liberado'                 },;
                {'BR_AZUL'      ,'Pedido de Venda com Bloqueio de Regra'    },;
                {'BR_LARANJA'   ,'Pedido de Venda com Bloqueio de Verba'    },;
                {'BR_PRETO'     ,'LUCRATIVIDADE E COMISS�O - GERENTE'       },;	// Customiza��o
				{'BR_PRETO_0'   ,'LUCRATIVIDADE E COMISS�O - DIRETOR'       } }	// Customiza��o
				

Return ( aLeg )