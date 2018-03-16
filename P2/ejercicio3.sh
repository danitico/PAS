#!/bin/bash
echo "===="
echo "Lista de archivos ocultos del directorio $HOME"
ls -a $HOME | grep -E '^\..*' | while read f
do
	echo "$f ${#f}"
done | sort -n -k 2 | sed -r -e 's/(.*)[[:space:]].*/\1/g'
echo "===="
echo "El fichero a procesar es $1"
cat $1 | sed -r '/^\s*$/d' > $1.sinLineasVacias
echo "El fichero sin líneas vacías se ha guardado en $1.sinLineasVacias"
echo "===="
ps -u $USER -o pid,start_time,comm | sed -r -n '1!p' | sed -r 's/^[[:space:]]*([0-9]*)[[:space:]]([0-9]*.[0-9]*)[[:space:]](.*)/Pid: "\1"  Hora:"\2" Ejecutable: "\3"/'
