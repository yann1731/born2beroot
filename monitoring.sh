#!/bin/bash
arc=$(uname -a)
cpu=$(cat /proc/cpuinfo | grep "cpu cores"| uniq | awk '{print $4}')
vcpu=$(nproc --all)
ram=$(free -m | grep "Mem" | awk '{print $2 / 1000}')
ramusage=$(free -m | grep "Mem" | awk '{print $3 / $2 * 100}')
storage=$(df -Bg | grep "boot" | awk'{tot += $}')
fdisk=$(df -Bg | grep '^/dev/' | grep -v '/boot$' | awk '{ft += $2} END {print ft}')
udisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} END {print ut}')
pdisk=$(df -Bm | grep '^/dev/' | grep -v '/boot$' | awk '{ut += $3} {ft+= $2} END {printf("%d"), ut/ft*100}')
ucpu=$(mpstat | grep "all" | awk '{print 100 - $13}')
lastboot=$(who -b | awk '{print $1: $3 $4}')
sincelb=$(uptime | awk '{print $2}')
lvmc=$(lsblk | grep "lvm" | wc -l)
lvmstat=$(if [ $lvmc -eq 0 ]; then echo no; else echo yes; fi)
con=$(ss | grep "tcp" | grep "ESTAB" | wc -l)
users=$(users | wc -w)
ip=$(hostname -I)
macaddr=$(ip link show | awk '$1 == "link/ether" {print $2}')
sudocmd=$(journalctl _COMM=sudo | grep "COMMAND" | wc -l)

wall " 
	#Architecture: $arc
	#Physical CPU cores: $cpu
	#Virtual CPU cores: $vcpu
	#Total RAM: $ram GB
	#RAM usage(%): $ramusage%
	#Storage space: udisk/${fdisk}Gb ($pdisk%)
	#CPU usage(%): $ucpu%
	#Date of last reboot: $lastboot
	#Elapsed time since last reboot: $sincelb
	#LVM status: $lvmstat
	#Active connections: $con
	#Users on server: $users
	#IPV4 adress: $ip
	#MAC adress: $macaddr
	#Number of sudo commands used: $sudocmd
	"