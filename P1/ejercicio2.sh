#!/bin/bash
if [ $# == 0 ]; #lo mismo que en el ejercicio 1
then
	echo "Error en la llamada al programa"
	exit
elif [ $# == 1 ];
then
	let tamano=0
else
	let tamano=$2-1 # Se le resta uno ya que en la busqueda con el comando find, la opcion busca archivos que sean > tamaño. Para incluir el >= se le ha restado 1
fi
echo "Nombre;LongitudUsuario;FechaModificacion;FechaAcceso;Tamano;Bloques;Permisos;Ejecutable"
find $1 -size +$tamano\c -type f | while read f # con el simbolo + antes de $tamano se buscan archivos que sean mayores que ese tamaño. Con el c despues de $tamano se determina que se esta midiendo en bytes
do
	a="$(stat -c "%U" $f)"; a=${#a} #Con ese uso de stat, hemos obtenido el usuario de ese archivo, y a continuacion se ha calculado su longitud
	if [ -x $f ]; #Con la opcion -x se comprueba si el fichero es ejecutable
	then
		b=1
	else
		b=0
	fi
	echo `stat -c "$(basename $f);$a;%y;%X;%s;%b;%A;$b" $f` # La opcion -c de stat sirve para modelar la salida de stat a nuestro gusto. El comando basename obtiene solamente el nombre de ese archivo, quitandole, por asi decirlo, su path 
done | sort -t";" -n -k 5 #Ordena la salida de este bucle. Con la opcion -t le decimos el delimitador que tiene esa salida. Las otras opciones se han comentado anteriormente
