#!/bin/bash
if [ $# == 1 ];
then
	let umbral1=10000
	let umbral2=100000
elif [ $# == 2 ];
then
	let umbral1=$2
	let umbral2=100000
elif [ $# == 3 ];
then
	let umbral1=$2
	let umbral2=$3
else
	echo "Se ha llamado mal al script"
	exit -1
fi
if [ -e pequenos/ -o -e medianos/ -o -e grandes/ ];
then
	echo "Las carpetas de salida ya existen, se va a proceder a borrarlas..."
	rm -rf pequenos/ medianos/ grandes/
	mkdir pequenos medianos grandes
else
	echo "Creando las carpetas pequenos, medianos y grandes..."
	mkdir pequenos medianos grandes
fi
echo "Copiando los archivos..."
find $1 -type f | while read f
do
	if [ $(stat -c "%s" $f) -lt $umbral1 ];
	then
		cp $f pequenos/
	elif [ $(stat -c "%s" $f) -ge $umbral1 -a $(stat -c "%s" $f) -le $umbral2 ];
	then
		cp $f medianos/
	elif [ $(stat -c "%s" $f) -gt $umbral2 ];
	then
		cp $f grandes/
	fi
done
