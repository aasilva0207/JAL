#include 'totvs.ch'

/*/{Protheus.doc} MA410COR
MA410COR - Alterar cores do cadastro do status do pedido 

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function MA410COR()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Declaracao de Variaveis                                                                     ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Local aCores := {} // PARAMIXB traz a estrutura do array padrão

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Atualização de novas legendas de                                                            ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	aAdd(aCores, {"C5_BLQ == '3'" , "BR_PRETO", "LUCRATIVIDADE E COMISSÃO"                                      })
	aAdd(aCores, {"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_BLQ)", "ENABLE", "Pedido em Aberto"      })
	aAdd(aCores, {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_BLQ)", "DISABLE", "Pedido Encerrado"       })
	aAdd(aCores, {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_BLQ)", "BR_AMARELO", "Pedido Liberado"   })
	aAdd(aCores, {"C5_BLQ == '1'", "BR_AZUL"                                                                    })
	aAdd(aCores, {"C5_BLQ == '2'", "BR_LARANJA"                                                                 })

Return ( aCores )
