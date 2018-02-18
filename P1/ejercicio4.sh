#!/bin/bash
echo "El numero de archivos en la carpeta actual es $(find . -maxdepth 1 -type f | wc -l)"
echo "Esta sería la lista de usuarios conectados en este momento: "
echo "----------"
echo "$(who -u | cut -d " " -f1 | uniq -u)"
if ! read -p "¿Qué caracter quieres contar? " -t5 caracter;
then
	caracter="a"
fi
let b=0
find . -maxdepth 1 -type d,f -name "*$caracter*" | ( while read f
do
	a=$(echo $f | tr -cd $caracter | wc -c)
	b=$[$a + $b]
done
echo "El caracter $caracter aparece $b veces en nombres de ficheros o carpetas contenidas en la carpeta actual" )

