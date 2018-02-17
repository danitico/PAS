#!/bin/bash
echo "Tenemos $(find $1 -name "*.c" | wc -l) ficheros con extension .c y $(find $1 -name "*.h" | wc -l) ficheros con extension.h"
find $1 -type f \( -name "*.c" -o -name "*.h" \) | while read f
do
	echo "El fichero $f tiene $(wc -l < $f) líneas y $(wc -c < $f) caracteres" >> "ejercicio1.txt"
done
cat ejercicio1.txt | sort -nr -k 8
rm -rf ejercicio1.txt
