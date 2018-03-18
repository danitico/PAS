#!/bin/bash
if [ $# != 2 ]; then
	echo "Se ha llamado mal al programa. Se necesita pasar por línea de argumentos el fichero con las IP y un timeout máximo"
	exit
fi
if [ -e tmp.txt ]; then
	rm -rf tmp.txt
fi
let milisegundos=$2*1000
cat $1 |  while read ip
do
	ping -c 1 -W $2 $ip >> /dev/null
	if [ $? -eq 0 ]; then
		ping -c 1 -W $2 $ip
	else
		echo "La IP $ip no respondió tras $milisegundos milisegundos"
	fi >> tmp.txt
done
cat tmp.txt | grep -E 'ttl|no' | sed -r -e 's/^[0-9]*.bytes.from.([0-9]*\.[0-9]*\.[0-9]*\.[0-9]*).*time=(.*)\s.*/La IP \1 respondió correctamente en \2 milisegundos/g' | sort -n -k 7
