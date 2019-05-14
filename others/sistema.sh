#!/usr/bin/env bash
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
 
#                           CABEÇALHO DO SCRIPT                               #

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
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
## REFERENCIAS
# 	<https://stackoverflow.com/questions/5947742/how-to-change-the-output-color-of-echo-in-linux>
# 	<https://stackoverflow.com/questions/3385003/shell-script-to-get-difference-in-two-dates>
#
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# # versão do script:              [1.37]         #
# # data de criação do script:    [23/10/17]      #
# # ultima ediçao realizada:      [14/05/19]      #
# # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# 
## COMPATIVEL COM
#	Debian Stable
# 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#  
# variaveis globais
date_now=$(date +%x-%k%M)
sistema=$(hostname)
#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#																				#
#                               CORPO DO SCRIPT                               	#
#																				#
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
neofetch_sistema()
{
	neofetch --disable terminal resolution memory --color_blocks off --gtk3 off ; echo
}

memoria_utilizada()
{
    echo "- Memoria RAM livre: $(free -h | awk '/Mem/ {print $4}') / $(free -h | awk '/Mem/ {print $2}')." ; echo
}

disco()
{
	echo "- Uso da raiz do root: $(df -h / | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 

	echo "- Uso da raiz do $(whoami): $(df -h /home | awk '/dev/sda1 {print $5}' | tail -1) / 100%." ; echo 
}

instalacao_sistema()
{
	install_system=$(ls -lct /etc | tail -1 | awk '{print $6, $7, $8}')

	echo "- Sistema instalado em $install_system."
}

twitts()
{
	arquivo="/home/lenonr/Dropbox/Arquivos/Twitter/posts"
	check_lastscanner=$(tail -1 /home/lenonr/Dropbox/Arquivos/Twitter/twitter_scanner)
	check_lastpost=$(cat /tmp/twitter_log | grep "NEW POST" | tail -1 | sed 's/NEW POST   - //g' )

	if [[ $sistema = "desktop" ]]; then
		# count=$(cat $arquivo | wc -l)
		count=$(wc -l $arquivo | awk '{print $1}')

		if [[ $count > 1 ]]; then
			echo "- $count twitts pendentes do bot!"			
		else
			echo "- 1 twitt pendente do bot!"			
		fi		
				
		echo "	- Last scanner: $check_lastscanner."
		echo "	- Last post:    $check_lastpost."
		echo
	fi	
}

commits()
{
	check_commit

	commits=$(cat /tmp/commits)

	if [[ $commits = "" ]]; then
		echo "- ERROR"
	elif [[ $commits = "0" ]]; then
		echo "- Voce nao possui acoes pendentes no GIT!"
	elif [[ $commits = "1" ]]; then
		echo -e "\e[1;31m- Voce possui 1 açao pendente no GIT. \e[0m"
	else
		echo -e "\e[1;31m- Voce possui $commits açoes pendentes no GIT. \e[0m"
	fi

	commits_add
	commits_com
}

commits_add()
{
	commits_add=$(cat /tmp/commits_add)
	cont_add=$(cat /tmp/commit_add.txt | tail -1 | sed -e 's/\dev_//g')

	if [[ $commits_add > "0" ]]; then
		if [[ $cont_add = "" ]]; then
			echo -e "\e[1;34m 	ADD: $commits_add\e[0m"	
		else
			echo -e "\e[1;34m 	ADD: $commits_add [ $cont_add]\e[0m"	
		fi		
	fi
}

commits_com()
{
	commits_com=$(cat /tmp/commits_com)
	cont_com=$(cat /tmp/commit_com.txt | tail -1 | sed -e 's/\dev_//g')

	if [[ $commits_com > "0" ]]; then
		if [[ $cont_com = "" ]]; then
			echo -e "\e[1;34m 	COM: $commits_com\e[0m"	
		else
			echo -e "\e[1;34m 	COM: $commits_com [ $cont_com]\e[0m"	
		fi
		
	fi

	echo
}

check_commit()
{
	### GERANDO ARQUIVOS ##
	if [[ ! -e "/tmp/commits"  ]]; then
		touch /tmp/commits
	else
		echo "0" > /tmp/commits	
	fi		

	if [[ ! -e "/tmp/commits_add"  ]]; then
		touch /tmp/commits_add
	else
		echo "0" > /tmp/commits_add
	fi		

	if [[ ! -e "/tmp/commits_com"  ]]; then
		touch /tmp/commits_com
	else
		echo "0" > /tmp/commits_com
	fi			

	source /home/lenonr/Github/dev_sysadmin/rotine_scripts/arquivos_git/status_git.sh >> /dev/null 
}

check_updates()
{
	arquivo_verifica="/tmp/checa_atualizacao"

	if [[ ! -e $arquivo_verifica  ]]; then
		touch $arquivo_verifica
		echo "" > $arquivo_verifica
	fi		

	verifica=$(cat $arquivo_verifica)

	if [[ $verifica == "" ]] || [[ $verifica == "Listing..." ]]; then
		echo "- Tudo atualizado!" ; echo
	else
		conta=$(wc /tmp/checa_atualizacao | awk {'print $1'-1})

		if [[ $conta > 1 ]]; then
			echo -e "\e[1;31m- $conta atualizaçoes disponiveis! \e[0m" ; echo
		else
			echo -e "\e[1;31m- 1 atualizaçao disponivel! \e[0m" ; echo					
		fi		
	fi	
}

report()
{
	if [[ $sistema = "notebook" ]]; then
		echo "############################# SYSTEM REPORT ##############################"
	else
		echo "################################ SYSTEM REPORT ################################"
	fi
	echo
	memoria_utilizada
	disco
	commits		
	twitts
	check_updates
	instalacao_sistema
	echo	
}

################################################
completo()
{	
	if [[ $sistema = "notebook" ]]; then
		echo "################################ NEOFETCH ################################"
		echo
	else
		echo "################################### NEOFETCH ##################################"
		echo
	fi

	neofetch_sistema	
	report
}

echo_p()
{
	if [[ $sistema = "notebook" ]]; then
		echo "##########################################################################"
	else
		echo "###############################################################################"
	fi
}

print_output()
{
	output="/tmp/sistema.txt"

	if [[ -e $output ]]; then
		touch $output
	fi

	completo > $output
	cat $output	
}

main()
{	
	clear 
		
	print_output	
	echo_p
}
    
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# INICIANDO SCRIPT
main