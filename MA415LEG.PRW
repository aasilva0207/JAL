#include 'totvs.ch'

/*/{Protheus.doc} MA415LEG
Este ponto de entrada pertence à rotina de atualização de orçamentos de venda, MATA415(). Usado, em conjunto com o ponto MA415COR,  
para alterar os textos da legenda, que representam o “status” do orçamento.

@type function
@version 12.1.33 
@author Anderson Alberto
@since 20/02/2024
@return variant, return_description
/*/

User Function MA415LEG()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aNovLeg  := {}

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclusão de novos Status                                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aNovLeg := {    {'ENABLE'       , 'Orcamento em Aberto'         },;
                    {'DISABLE'      , 'Orcamento Baixado'           },;
                    {'BR_PRETO'     , 'Orcamento Cancelado'         },;
                    {'BR_AMARELO'   , 'Orcamento nao Orcado'        },;
                    {'BR_AZUL'      , 'Orcamento aprovado'          },;
                    {'BR_PRETO'     , 'Orcamento bloqueio GERENTE'  },;
                    {'BR_PRETO_0'   , 'Orcamento bloqueio DIRETOR'  }}

Return( aNovLeg )
