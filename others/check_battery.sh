#!/usr/bin/env bash
#
######################################################################
# DESCRICAO
#		Descreve informacoes da duracao da bateria do computador
######################################################################
#
# DAT_CRIAC	:	07/01/19
# LAST_MOD	:	06/09/19
# VERSAO	:	1.05
# AUTOR 	:	lenonr
#
######################################################################
#
## REFERENCE
# https://github.com/sagarrakshe/battery-script/blob/master/battery.sh
#
######################################################################
#
check()
{
	status="$(cat /sys/class/power_supply/BAT0/status)"
	full_battery="$(($(cat /sys/class/power_supply/BAT0/charge_full) / 1000))"
	charge_now="$(($(cat /sys/class/power_supply/BAT0/charge_now) / 1000))"
	current_now="$(($(cat /sys/class/power_supply/BAT0/current_now) / 1000))"
	current="$(cat /sys/class/power_supply/BAT0/current_now)"
	full_design="$(cat /sys/class/power_supply/BAT0/charge_full)"

	time="$(ibam --percentbattery | grep "Adapted battery time left:"| awk {'print $5'})"
	percent="$(ibam --percentbattery | grep "Battery percentage:"| awk {'print $3$4'})"
	level="$(ibam --percentbattery | grep "Battery percentage:"| awk {'print $3'})"

	expected_time_h=${time:0:1}
	expected_time_m=${time:2:2}
	expected_time_s=${time:5:5}	

	low_res="$((($full_battery * 30) / 100))"
	med_res="$((($full_battery * 60) / 100))"
	high_res="$((($full_battery * 75) / 100))"

	expected_time="$(date -d "$expected_time_h hours $expected_time_m minutes" +%R)"
	expected_full_charge="$(ibam -a | grep "Bios time left:"| awk {'print $4'})"

	date_rest="$battery_res"

	######################################################################
	if [[ $current > 0 ]]; then
		current_now="$(($current / 1000))"	
		battery_res="$((($full_battery * 60) / $current_now))"
		battery_res_h="$(($battery_res / 60))"
		perc_batery="$(((($charge_now * 100)) / $full_battery))"
		battery_full="$((($full_battery * 60) / $current_now))"
		calc_time=$(($battery_full - $battery_res))
	fi					

	if [[ $current_now -le $low_res ]] && [[ $current_now -le $med_res ]]; then
		consuming_level=$(echo -e "\e[1;32m[===]- \e[0m")
	elif [[ $current_now -ge $med_res ]] && [[ $current_now -le $high_res ]] ; then
		consuming_level=$(echo -e "\e[1;33m[===]- \e[0m")
	elif [[ $current_now -ge $high_res ]] ; then
		consuming_level=$(echo -e "\e[1;31m[===]- \e[0m")
	else
		consuming_level="ERROR"
	fi	

	## check level battery
	if [[ "10" -ge $level ]]; then
		percent_level="[+---------]"
	elif [[ "20" -ge $level ]]; then
		percent_level="[++--------]"
	elif [[ "30" -ge $level ]]; then
		percent_level="[+++-------]"
	elif [[ "40" -ge $level ]]; then
		percent_level="[++++------]"
	elif [[ "50" -ge $level ]]; then
		percent_level="[+++++-----]"
	elif [[ "60" -ge $level ]]; then
		percent_level="[++++++----]"
	elif [[ "70" -ge $level ]]; then
		percent_level="[+++++++---]"
	elif [[ "80" -ge $level ]]; then
		percent_level="[++++++++--]"
	elif [[ "90" -ge $level ]]; then
		percent_level="[+++++++++-]"
	elif [[ "100" -ge $level ]]; then
		percent_level="[++++++++++]"
	else
		percent_level="[**ERROR**]"
	fi	

	if [[ $status == "Discharging" ]]; then						
		echo -e "Status:\e[1;31m $status"" \e[0m"
		echo "Time rest:" $time "/" $percent	
		echo "Consuming now:" $current_now "mA /" $consuming_level
		echo "Battery rest:" $charge_now "mAh / $percent_level"		
		echo "Expected shutdown:" $expected_time
	elif [[ $status == "Charging" ]]; then						
		echo -e "Status battery:\e[1;32m $status"" \e[0m"
		echo "Percent to full:" $expected_full_charge / $(((100 - $perc_batery))) "%"
		echo "Consuming now:" $current_now "mA / $consuming_level"
		echo "Battery rest to full charge: $(($full_battery - $charge_now)) mAh"	
		echo "Full battery:" $charge_now "mAh"
	elif [[ $status == "Full" ]]; then
		echo -e "Status battery:\e[1;34m Full"" \e[0m"
	else
		echo "ERROR"
	fi		

	# echo "Temperature: "$(sensors | grep temp1 | awk {'print $2'})
}

main()
{	
	while [[ TRUE ]]; do		
		if [[ -e "/sys/class/power_supply/BAT0/status" ]]; then
			clear
			echo "#####################################"	
			check
			echo "#####################################"
			sleep 2.5
		else
			clear
			echo "##################"
			echo "BATTERY NOT FOUND!"
			echo "##################"
			sleep 5			
		fi		
	done	
}

main