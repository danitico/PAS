#!/bin/bash
if [ $# == 1 ];
then
	let tamano=0
else
	let tamano=$2-1
fi
echo "Nombre;LongitudUsuario;FechaModificacion;FechaAcceso;Tamano;Bloques;Permisos;Ejecutable"
find $1 -size +$tamano\c -type f | while read f
do
	a="$(stat -c "%U" $f)"; a=${#a}
	if [ -x $f ];
	then
		b=1
	else
		b=0
	fi
	echo `stat -c "$(basename $f);$a;%y;%X;%s;%b;%A;$b" $f` >> "ejercicio2tmp.txt"
done
cat ejercicio2tmp.txt | sort -t";" -n -k 5
rm -rf ejercicio2tmp.txt
