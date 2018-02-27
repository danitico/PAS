#!/bin/bash
echo "El numero de archivos en la carpeta actual es $(find . -maxdepth 1 -type f | wc -l)" # con la opcion -maxdepth 1 solo buscamos en los ficheros de esa carpeta y se evita la busqueda recursiva en subdirectorios. El resultado de esto se lo pasamos mediante una tuberia a wc -l que nos cuenta el numero de lineas que ha recibido, es decir, el numero de archivos
echo "Esta sería la lista de usuarios conectados en este momento: "
echo "----------"
echo "$(who -u | cut -d " " -f1 | uniq -u)" # Con el comando who -u vemos los usuarios conectados. Con el comando cut -d " " -f1 obtenemos la primera columna de la salida del comando anterior. Con el comando uniq -u, se muestran los usuarios sin repetirse.
if ! read -p "¿Qué caracter quieres contar? " -t5 caracter; # Si el usuario no responde en 5 segundos (-t 5), se asigna como defecto a caracter la cadena a
then
	caracter="a"
fi
let b=0
find . -maxdepth 1 -name "*$caracter*" | ( while read f #Buscamos en el directorio, sin movernos por subdirectorios ya que (-maxdepth 1) y buscamos nombres de ficheros o directorios que se ajusten a "*$caracter*", es decir, que tengan el caracter que se ha introducido
do
	a=$(echo $f | tr -cd $caracter | wc -c) #le pasamos el nombre del fichero o directorio al comando tr, que lo que hace es borrar del nombre pasado aquellos caracteres que no sean $caracter y a continuacion le pasamos esa salida a wc -c para contar el numero de $caracter que hay ahi
	b=$[$a + $b] #variable contador
done
echo -e "\nEl caracter $caracter aparece $b veces en nombres de ficheros o carpetas contenidas en la carpeta actual" )
