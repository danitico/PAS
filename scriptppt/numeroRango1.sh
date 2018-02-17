#!/bin/bash
read -p "Introduce un número (1 <= x< 10): " numero
if [ $numero -lt 1 ] || [ $numero -ge 10 ];
then
  echo "Fuera de rango!"
else
  echo "El número $numero es correcto!"
fi
