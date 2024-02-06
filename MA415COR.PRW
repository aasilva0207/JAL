#include 'totvs.ch'

/*/{Protheus.doc} MA415COR
Ponto-de-Entrada: MA415COR - Alterar cores do browse do cadastro de status do orçamento

@type function
@version 12.1.33 
@author Anderson Alberto
@since 19/01/2024
@return variant, return_description
/*/

User Function MA415COR()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aRetCores := {}

    //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Inclusão de novos Status                                                                    ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
    aCores := {	{"SCJ->CJ_STATUS == 'A'" , "ENABLE"     },;   // Orcamento em Aberto            
                {"SCJ->CJ_STATUS == 'B'" , "DISABLE"    },;   // Orcamento Baixado            
                {"SCJ->CJ_STATUS == 'C'" , "BR_PRETO"   },;   // Orcamento Cancelado            
                {"SCJ->CJ_STATUS == 'D'" , "BR_AMARELO" },;   // Orcamento nao Orcado            
                {"SCJ->CJ_STATUS == 'E'" , "BR_AZUL"    },;   // Orcamento aprovado Parâmetros
                {"SCJ->CJ_STATUS == '0'" , "BR_PRETO"   },;   // Orcamento bloqueio GERENTE
                {"SCJ->CJ_STATUS == '1'" , "BR_PRETO_0" } }   // Orcamento bloqueio DIRETOR

Return( aRetCores )
