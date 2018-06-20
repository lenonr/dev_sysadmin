#!/bin/bash

#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                           CABEÇALHO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # # # # # # # # # # # #
#   DESENVOLVIDO POR    #
# # # # # # # # # # # # #
#
# por lenonr(Lenon Ricardo)
#       contato: <lenonrmsouza@gmail.com>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#									      									  #
#	If I have seen further it is by standing on the shoulders of Giants.      #
#	(Se vi mais longe foi por estar de pé sobre ombros de gigantes)	          #
#							~Isaac Newton	      							  #
#									      									  #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# # # # # # # # # # # # # # # # # # # # # # # # # #
# # data de criação do script:    [19/06/18]      #             
# # ultima ediçao realizada:      [19/06/18]      #
# # # # # # # # # # # # # # # # # # # # # # # # # #
#
# versao do script
    VERSAO="0.0.10.0.0.0"             
#    
# Legenda: a.b.c.d.e.f
# 	a = alpha[0], beta[1], stable[2], freeze[3];
# 	b = erros na execução;
# 	c = interações com o script;
# 	d = correções necessárias; 
# 	e = pendencias
# 	f = desenvolver
#				
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # Mensagens de Status
#       [+] - Ação realizada;
#       [*] - Processamento;
#       [-] - Não executado;
#       [!] - Mensagem de aviso;
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#
# # Script testado em
#   - Debian 10     - Testing
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                               CORPO DO SCRIPT                               #
#                                                                             #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # variaveis do script
local_home="/home/lenonr/"
git="/home/lenonr/Github/dev_xfce/Auto_Config/base/"
arquivo=".zshrc"

# # FUNCOES
f_envia()
{	
	cd $local_home
	printf "[*] Enviando arquivo zshrc para $git\n" 
	cat .zshrc > $git/$arquivo
	printf "[+] Backup realizado! \n"
}

f_restaura()
{
	cd $git
	printf "[*] Restaurando arquivo zshrc para $local_home\n" 
	cat .zshrc > $local_home/$arquivo
	printf "[+] Backup realizado! \n"
}

f_verifica()
{
	[[ $# -eq 0 ]] && \
		printf "Digite como parametros " && \
		printf "\n- envia(de $local_home$arquivo para $git$arquivo) ou " && \
		printf "\n- restaura(de $git$arquivo para $local_home$arquivo)"
}

main()
{
	clear
	f_verifica

	for i in "$@"; 
	do
	    # verificando o que foi digitado
	    case $i in
	        envia) f_envia;;
	        restaura) f_restaura;;
	        *) echo "nao entendi"
	    esac    
	done
}

## chamando script
main $@

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                               #
#                           RODAPE DO SCRIPT                                    #
#                                                                               #
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #