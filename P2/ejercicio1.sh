#!/bin/bash
echo "*******"
echo "1)Lineas con la duracion de las peliculas:"
cat $1 | grep -E '^[0-9]hr.[0-9][0-9]min'
echo "*******"
echo "2) Lineas con el pais de las peliculas:"
cat $1 | grep -E '\-(.*)-$'
echo "*******"
echo "3) Solo el país de las películas:"
cat $1 | grep -E -o '\-(.*)-$' | grep -E -o '[^\-][[:alpha:]]*.[[:alpha:]]*.(..)*[[:alpha:]][^\-]'
echo "*******"
echo "4) Hay `cat $1 | grep -E -c '2016'` del 2016 y `cat $1 | grep -E -c '2017'` del 2017"
echo "*******"
echo "5) Eliminar líneas vacías:"
cat $1 | grep -E -v '^$'
echo "*******"
echo "Líneas que empiezan con la letra E (con o sin espacios antes):"
cat $1 | grep -E '(^[E]|^\ *[E]).*'
echo "*******"
echo "Líneas que contienen d, l o t, una vocal y la misma letra:"
cat peliculas.txt | grep -E 'd[aeiou]d|l[aeiou]l|t[aeiou]t'
echo "*******"
echo "8) Líneas que contienen ocho aes o más"
cat $1 | grep -E '(.*[Aa].*){8,}'
echo "*******"
echo "9) Líneas que terminan con tres puntos y no empiezan por espacio:"
cat $1 | grep -E '^[^\ *].*\.{3,3}$'
echo "*******"
echo "10) Mostrar entre comillas las vocales con tilde:"
cat $1 | sed -r -e 's/á/"á"/g; s/é/"é"/g; s/í/"í"/g; s/ó/"ó"/g; s/ú/"ú"/g; s/Á/"Á"/g; s/É/"É"/g; s/Í/"Í"/g; s/Ó/"Ó"/g; s/Ú/"Ú"/g'
