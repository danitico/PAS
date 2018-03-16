#!/bin/bash
cat $1 |  while read ip
do
	comando=$(ping -c 1 -W 3 $ip)
	if [ "$comando"  a.txt ];
	then
		echo "hey"
	fi
done
