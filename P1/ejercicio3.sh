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
if [ -e pequenos/ -o -e medianos/ -o -e grandes/ ]; #Vemos si existe alguna de las carpetas, si es así, se borran
then
	echo "Las carpetas de salida ya existen, se va a proceder a borrarlas..."
	rm -rf pequenos/ medianos/ grandes/ #se borran con el comando rm -rf <nombre>
	mkdir pequenos medianos grandes #se crean las carpetas
else
	echo "Creando las carpetas pequenos, medianos y grandes..."
	mkdir pequenos medianos grandes
fi
echo "Copiando los archivos..."
find $1 -type f | while read f #mismo bucle
do
	if [ $(stat -c "%s" $f) -lt $umbral1 ]; #Se compara el tamaño de los archivos
	then
		cp $f pequenos/ # y se meten en las carpetas correspondientes con cp <fichero> <carpetadestino>
	elif [ $(stat -c "%s" $f) -ge $umbral1 -a $(stat -c "%s" $f) -le $umbral2 ];
	then
		cp $f medianos/
	elif [ $(stat -c "%s" $f) -gt $umbral2 ];
	then
		cp $f grandes/
	fi
done
