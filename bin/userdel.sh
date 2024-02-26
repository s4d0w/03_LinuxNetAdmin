#!/bin/bash

cat /root/bin/passwd.txt | while read UNAME PASSWD
do
	userdel -r $UNAME
done
