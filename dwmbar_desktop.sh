#!/bin/bash

print_mpd_time() {
	mpcTime=$(mpc -p 6601 | sed -n 2p | awk '{print $3}')
	echo -e "$mpcTime"
}

print_mpd() {
	mpcCurrent=$(mpc -p 6601 current)
	echo -e "$mpcCurrent"
}

print_volume() {
	volume=$(echo $(pulsemixer --get-volume | awk '{print $2}')%)
	echo -e "$volume"
}

print_wifi() {
	ip=$(ip addr|awk '/enp2s0/ && /inet/ {gsub(/\/[0-9][0-9]/,""); print $2}')
	echo -e "$ip"
}

print_mem() {
	memFree=$(($(grep -m1 'MemAvailable:' /proc/meminfo | awk '{print $2}') / 1024))
	memSym=$(echo "MB")
	echo -e "$memFree$memSym"
}

print_date(){
	date=$(date +"%m-%d")
	time=$(date +"%r")
	echo -e "$date |$time"
}

separator(){
	sep=$(echo " |")
	echo -e "$sep"
}

symbol() {
	echo -e "╬"
}

while true
do
	xsetroot -name "$(print_mpd_time) $(print_mpd)$(separator)$(print_volume)$(separator)$(print_mem)$(separator)$(print_wifi)$(separator)$(print_date)$(separator)$(symbol)"

	sleep 1
done
