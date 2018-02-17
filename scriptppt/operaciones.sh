#!/bin/bash
read -p "Introduzca un primer numero: " a
read -p "Introduzca un segundo numero: " b
echo "Suma: $[$a+$b]"
echo "Resta: $[$a-$b]"
echo "Multiplicación: $[$a*$b]"
echo "División: $[$a/$b]"
echo "Módulo: $[$a%$b]"
