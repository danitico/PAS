#!/bin/bash
if [ $# != 1 ]; # $# indica el numero de argumentos. Si no se le pasa ninguno, $# es 0
then
	echo "Error en la llamda al programa"
	exit
fi
echo "Tenemos $(find $1 -name "*.c" | wc -l) ficheros con extension .c y $(find $1 -name "*.h" | wc -l) ficheros con extension.h"
find $1 -type f \( -name "*.c" -o -name "*.h" \) | while read f
do
	echo "El fichero $f tiene $(wc -l < $f) líneas y $(wc -c < $f) caracteres" # wc -l para contar numero de lineas y -c para caracteres
done | sort -nr -k 8 #Se ordena numéricamente(-n) de mayor a menor (-r) la columna 8 (-k)
