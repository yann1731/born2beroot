#!/bin/bash

arc=$(uname -a)
cpu=$(cat /proc/cpuinfo | grep "cpu cores"| uniq | awk '{print $4}')
vcpu=$(nproc --all)
ram=$(free -m | grep "Mem" | awk '{print $2 / 1000}')
ramusage=$(free -m | grep "Mem" | awk '{print $3 / $2 * 100}')

wall " #Architecture: $arc
	#Physical CPU cores: $cpu
	#Virtual CPU cores: $vcpu
	#Total RAM: $ram GB
	#RAM usage: $ramusage % "