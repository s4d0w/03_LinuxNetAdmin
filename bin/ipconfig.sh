#!/bin/bash

export LANG=en_US.UTF-8

TMP1=/tmp/.tmp1

nmcli -f NAME connection | tail -n +2 > $TMP1
for CON in $(cat $TMP1)
do
echo

METHOD=$(echo $(nmcli connection show $CON | grep "ipv4.method:" | awk -F: '{print $2}'))
NIC=$(nmcli connection | grep "^$CON" | awk '{print $4}')

if [ "$METHOD" = 'manual' ] ; then
	IP=$(nmcli connection show $CON | grep "ipv4.addresses:" | awk -F: '{print $2}')
	GW=$(nmcli connection show $CON | grep "ipv4.gateway:" | awk -F: '{print $2}')
	DNS=$(nmcli connection show $CON | grep "ipv4.dns:" | awk -F: '{print $2}')
elif [ "$METHOD" = 'auto' ] ; then
	IP=$(nmcli connection show $CON | fgrep 'IP4.ADDRESS[1]:' | awk -F: '{print $2}')	
	GW=$(nmcli connection show $CON | grep 'IP4.GATEWAY:' | awk -F: '{print $2}')	
	DNS=$(nmcli connection show $CON | fgrep 'IP4.DNS[1]:' | awk -F: '{print $2}')	
else
	echo "[ FAIL ] Only 'manual' and 'auto' settings can be checked."
fi

cat << EOF
Connection Name ...... : $CON
Ethernet adapter ..... : $(echo $NIC)
IPv4 Address ......... : $(echo $IP)
Default Gateway ...... : $(echo $GW)
DNS Servers .......... : $(echo $DNS)
EOF

done
echo 
