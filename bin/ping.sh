#!/bin/bash

START=200
END=245
NET=172.16.6
LOG=/root/bin/ping.log
TMP1=$(mktemp)

for i in $(seq $START $END)
do
	ping -c 1 -W 1 $NET.$i >/dev/null 2>&1
	if [ $? -eq 0 ] ; then
		echo "[  OK  ] $i is alive." | tee -a "$LOG"
		echo "$i" >> $TMP1
	else
		echo "[ FAIL ] $i is dead." | tee -a "$LOG"
	fi
done


