#!/bin/bash
arc=$(uname -a)
cpu=$(cat /proc/cpuinfo | grep "cpu cores"| uniq | awk '{print $4}')
vcpu=$(nproc --all)
ram=$(free -m | grep "Mem" | awk '{print $2 / 1000}')
ramusage=$(free -m | grep "Mem" | awk '{print $3 / $2 * 100}')
storage=$(df -Bg | grep "boot" | awk'{tot += $}')

wall " 
	#Architecture: $arc
	#Physical CPU cores: $cpu
	#Virtual CPU cores: $vcpu
	#Total RAM: $ram GB
	#RAM usage(%): $ramusage %
	#Storage space:
	#Disk usage(%):
	#CPU usage(%): <---------- mpstat
	#Date of last reboot:
	#Elapsed time since last reboot:
	#LVM status:
	#Active connections:
	#Users on server:
	#IPV4 adress:
	#MAC adress:
	#Number of sudo commands used:
	"