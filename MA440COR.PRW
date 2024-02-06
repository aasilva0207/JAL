#include 'totvs.ch'

/*/{Protheus.doc} MA440COR
MA440COR - O ponto de entrada MA440COR possibilita alterar as regras das cores e as cores da libera��o dos pedidos de vendas.

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function MA440COR()

	//���������������������������������������������������������������������������������������������Ŀ
	//� Declaracao de Variaveis                                                                     �
	//�����������������������������������������������������������������������������������������������
	Local aCores := PARAMIXB	// PARAMIXB traz a estrutura do array padr�o

	//���������������������������������������������������������������������������������������������Ŀ
	//� Atualiza��o de novas legendas de                                                            �
	//�����������������������������������������������������������������������������������������������
	aAdd(aCores, {  "C5_XBLQ == '3'" , 'BR_PRETO'	, 'LUCRATIVIDADE E COMISS�O - GERENTE'  })
	aAdd(aCores, {  "C5_XBLQ == '4'" , 'BR_PRETO_0'	, 'LUCRATIVIDADE E COMISS�O - DIRETOR'  })

Return ( aCores )