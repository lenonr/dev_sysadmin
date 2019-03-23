#!/usr/bin/env bash
#
####################
# DATA_CRIACAO: 23/03/19
# ULT_MODIFIC : 23/03/19
# VERSAO 	  : 0.15
####################
#
## REFERENCE
# 	https://www.semicomplete.com/projects/xdotool/
#	https://superuser.com/questions/196532/how-do-i-find-out-my-screen-resolution-from-a-shell-script
#
## CHECK
# 	Spotify
# 	Janelas multiplas do mesmo programa(sobreposicao estranha na tela)
# 	Porcentagem monitor de diferente resolucao
#
resolution()
{
	## porcentagem da resolução
	taxa_width="93"
	taxa_height="83"

	width=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f1)
	height=$(xrandr --current | grep '*' | uniq | awk '{print $1}' | cut -d 'x' -f2)	

	calc_width=$((($width * $taxa_width) / 100))
	calc_height=$((($height * $taxa_height) / 100))

	# echo $calc_width
	# echo $calc_height
}

check()
{
	WIDS=`xdotool search --onlyvisible --name "$1"`

	for id in $WIDS; do
	  xdotool windowsize $id $calc_width $calc_height && \
	  xdotool windowmove -- $id 50 50
	done
}

main()
{
	resolution	

	if [[ $1 = "" ]]; then
		echo "ERROR: É necessário passar o nome da aplicativo como parametro!"
		exit 1
	else
		check $1
	fi
}

main $1