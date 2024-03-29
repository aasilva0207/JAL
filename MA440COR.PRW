#include 'totvs.ch'

/*/{Protheus.doc} MA440COR
MA440COR - O ponto de entrada MA440COR possibilita alterar as regras das cores e as cores da libera豫o dos pedidos de vendas.

@type function
@version 12.1.33 
@author Anderson Alberto
@since 15/01/2024
@return variant, return_description
/*/

User Function MA440COR()

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Declaracao de Variaveis                                                                     �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	Local aCores := {} // PARAMIXB traz a estrutura do array padr�o

	//旼컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�
	//� Atualiza豫o de novas legendas de                                                            �
	//읕컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴읕컴컴컴컴컴컴컴컴컴컴컴�
	aAdd(aCores, {  "C5_BLQ == '3'" , "BR_PRETO", "LUCRATIVIDADE E COMISS홒"  })

Return ( aCores )
