#!/bin/bash
echo -n "Introduzca un numero: "; read x;
let sum=0; let i=1;
while [ $i -le $x ];
do
	let "sum = $sum + $i"
	let "i = $i + 1"
done
echo "La suma de los primeros $x numeros es: $sum"
