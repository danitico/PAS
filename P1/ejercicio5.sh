#!/bin/bash
if [ $# == 0 ];
then
	echo "Error en la llamada al script"
	exit
fi
if [ ! -e copia/ ]; #si no existe la carpeta, se crea con el comando mkdir <nombrecarpeta>
then
	mkdir copia
fi
tiempo=$(date +%s) #calculamos el tiempo en segundos desde epoch con la opcion +%s
tar -czf "copia-$USER-$tiempo.tar.gz" $* #tar -cvf <nombrearchivo> sirve para comprimir el archivo y como curiosidad, descomprimir tar -xvf <archivotar> 
mv "copia-$USER-$tiempo.tar.gz" copia/ # mueve el tar a la carpeta copia/
echo "La copia de seguridad se ha creado correctamente"
find copia/ -type f | while read f #buscamos en la carpeta copia/ por archivos cuya "antiguedad" sea mayor que 200 segundos y se borra
do
	if [ $(($(date +%s) - $(stat -c "%Y" $f))) -gt 200 ]; #Se supone que %W nos da los segundos desde epoch de la creacion del archivo pero es unknown, por lo que se pondra la fecha de ultima modificacion %Y, ya que no se va a modificar
	then
		echo "Borrando $(readlink -f $f) de $(($(date +%s) - $(stat -c "%Y" $f))) segundos..."
		rm -rf $f
	fi
done
