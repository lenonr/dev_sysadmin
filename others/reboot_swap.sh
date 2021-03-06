#!/usr/bin/env bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   FONTES DE PESQUISA  #
# # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# Referencia: <https://www.vivaolinux.com.br/script/Verificar-eou-limpar-cache-de-memoria>
#   Autor: Pedro - Viva o Linux
# 
# Referencia: <http://www.hardware.com.br/guias/programando-shell-script/variaveis-comparacao.html>
#   Autor: Carlos E. Morimoto - Guia do Hardware
#
# Referencia: <https://elias.praciano.com/2016/03/perguntas-e-respostas-sobre-o-swap/>
#	Autor: Limpando swap com script otimizado
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # 
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # # 
#
# por lenonr(Lenon Ricardo) 
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#	If I have seen further it is by standing on the shoulders of Giants.		#
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)				#
#							~Isaac Newton										#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:           [0.1.123.0.0.0]   #
# # data de criação do script:    [03/11/17]      #
# # ultima ediçao realizada:      [28/07/19]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;	
# 	c = interações com o script;
# 	d = correções necessárias;
# 	e = pendencias    
# 	f = desenvolver 
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#   [+] - Açao realizada; 
#   [*] - Processamento;
#   [-] - Não executado;
#   [!] - Mensagem de aviso;
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # Script testado em
#   - Debian Stable
#
# # Compativel com
#   - Debian Stable
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# DESCRICAO
#	Reinicia a memoria swap de acordo com a quantidade de memoria RAM disponivel.
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                               CORPO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
## VARIAVEIS
## log de saida
local="/tmp/clear_memory.txt"

## minimo de memoria RAM para limpeza - taxa/100
porcentagem_mem="70"

# realizando verificação de root
if [[ `id -u` -ne 0 ]]; then       
    printf "############################################################################ \n"
    printf "[!] O script para funcionar, precisa estar sendo executado como root! \n"
    printf "[!] Favor, logar na conta root e executar o script novamente. \n"
    printf "############################################################################ \n"    
    exit 1
fi

limpa()
{
	swapoff -a && swapon -a && printf "\e[1;32mSUCESS - \e[0m" >> $local && date >> $local
}

porcentagem()
{

	# variaveis de verificacao da memoria RAM
	memoria_total=$(free | awk '/Mem:/ {print $2}')	

	# calculando taxa de memoria
	memoria_taxa=$(($porcentagem_mem * ($memoria_total / 100)))

	# memoria livre
	memoria_livre=$(free | awk '/Mem:/ {print $4}')

	# verificando a memoria SWAP
	swap=$(LC_ALL=C free | awk '/Swap:/ {print $3}')
						
	# verificando memoria
	if [[ $memoria_livre > $memoria_taxa ]]; then		
		limpa
	else
		printf "\e[1;31mFAILED - \e[0m" >> $local && date >> $local
	fi
}

main()
{
	porcentagem	
}

# # executando script
main

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           RODAPE DO SCRIPT                                    #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
