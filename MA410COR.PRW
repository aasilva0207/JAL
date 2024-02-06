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

	//���������������������������������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                                                     �
	//�����������������������������������������������������������������������������������������������
	Local aCores := {} // PARAMIXB traz a estrutura do array padr�o

	//���������������������������������������������������������������������������������������������Ŀ
	//� Atualiza��o de novas legendas de                                                            �
	//�����������������������������������������������������������������������������������������������
	aAdd(aCores, {"C5_XBLQ == '3'",'BR_PRETO'	, 'LUCRATIVIDADE E COMISS�O - GERENTE'                      	})
	aAdd(aCores, {"C5_XBLQ == '4'",'BR_PRETO_0'	, 'LUCRATIVIDADE E COMISS�O - DIRETOR'							})
	aAdd(aCores, {"Empty(C5_LIBEROK).And.Empty(C5_NOTA) .And. Empty(C5_XBLQ)", "ENABLE", "Pedido em Aberto"     })
	aAdd(aCores, {"!Empty(C5_NOTA).Or.C5_LIBEROK=='E' .And. Empty(C5_XBLQ)", "DISABLE", "Pedido Encerrado"      })
	aAdd(aCores, {"!Empty(C5_LIBEROK).And.Empty(C5_NOTA).And. Empty(C5_XBLQ)", "BR_AMARELO", "Pedido Liberado"  })
	aAdd(aCores, {"C5_XBLQ == '1'", "BR_AZUL"                                                                   })
	aAdd(aCores, {"C5_XBLQ == '2'", "BR_LARANJA"                                                                })

Return ( aCores )