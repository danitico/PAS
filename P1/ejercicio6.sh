#!/bin/bash
busquedacarpetas(){
	echo "<ul>"
	find $1 -maxdepth 1 | while read j
	do
	if [ -d $j -a $j != $1 ];
		then
			echo "<li><strong>$(readlink -f $j)</strong></li>"
			busquedacarpetas $j
	elif [ -f $j ];
   then 
   	echo "<li>$(readlink -f $j)</li>"
   fi
   done
	echo "</ul>"
}
creacionhtml(){
	echo "<html>"
	echo "<head>"
	echo "<title>Listado del directorio $1</title>"
	echo "</head>"
	echo "<body>"
	echo "<style> type=\"text/css\">"
	echo "body{font-family: sans-serif;}"
	echo "</style>"
	echo "<h1>Listado del directorio $1</h1>"
	echo "<ul>"
	find $1 -maxdepth 1 | while read f
	do
		if [ -d $f -a $f != $1 ];
		then
			echo "<li><strong>$(readlink -f $f)</strong></li>"
			busquedacarpetas $f
		elif [ -f $f ];
		then 
			echo "<li>$(readlink -f $f)</li>"
		fi
	done
	echo "</ul>"
	echo "</body>"
	echo "</html>"
}
if [ $# != 1 ];
then
	echo "Error en la llamada al programa"
else
	creacionhtml $1 > "$(basename $1).html"
fi
