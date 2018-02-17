#!/bin/bash
if [ $# == 0 ];
then
  echo "El uso del programa es $0 nombreFichero"
elif [ -e $1 ];
  then
    fecha=`date +%d-%m-%y`
    nuevofichero="$1.bak_$fecha"
    cp $1 $nuevofichero
else
    echo "El fichero no existe"
fi
