#!/bin/bash
echo "*******"
echo "1)Lineas con la duracion de las peliculas:"
cat $1 | grep -E '^[0-9]hr.[0-9][0-9]min'
echo "2) Lineas con el pais de las peliculas:"
cat $1 | grep -E '^\(*\).-*-'
