#!/bin/bash
if [ $# != 1 ];
then
	echo "Error en la llamda al programa"
	exit
fi
echo "Tenemos $(find $1 -name "*.c" | wc -l) ficheros con extension .c y $(find $1 -name "*.h" | wc -l) ficheros con extension.h"
find $1 -type f \( -name "*.c" -o -name "*.h" \) | while read f
do
	echo "El fichero $f tiene $(wc -l < $f) líneas y $(wc -c < $f) caracteres"
done | sort -nr -k 8
