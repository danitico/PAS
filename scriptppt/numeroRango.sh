#!/bin/bash
read -p "Introduzca un número (1 <= x <10): " numero
if [ $numero -lt 1 ];
then
  echo "Fuera de rango"
elif [ $numero -ge 10 ];
then
  echo "Fuera de rango"
else
  echo "El número $numero es correcto!"
fi
