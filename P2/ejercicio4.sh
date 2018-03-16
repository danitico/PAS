#!/bin/bash
if [ -e tmp.txt ]; then
	rm -rf tmp.txt
fi
let milisegundos=$2*1000
cat $1 |  while read ip
do
	ping -c 1 -W $2 $ip 2>&1 >/dev/null
	if [ $? -eq 0 ]; then
		ping -c 1 -W $2 $ip
	else
		echo "La IP $ip no respondió tras $milisegundos milisegundos"
	fi >> tmp.txt
done
cat tmp.txt | grep -E 'time|no' | sed -r -e 's/^[0-9]*.bytes.from.([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*).*time=(.*)\s.*/La IP \1 respondió correctamente en \2 milisegundos/g' | sort -n -k 7
