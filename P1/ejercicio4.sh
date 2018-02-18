#!/bin/bash
echo "El numero de archivos en la carpeta actual es $(find . -maxdepth 1 -type f | wc -l)"
echo "Esta sería la lista de usuarios conectados en este momento: "
echo "----------"
echo "$(who -u | cut -d " " -f1 | uniq -u)"
if ! read -p "¿Qué caracter quieres contar" -t5 caracter;
then
	caracter="a"
fi
echo "El caracter $caracter aparece $(find . -name "*$caracter*"

