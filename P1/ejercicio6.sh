#!/bin/bash -x
busquedacarpetas(){
	find $1 -type f,d | while read f
	do
     	if [ -f $f ];
      then 
         echo "<li>$(readlink -f $f)</li>"
      fi
   done
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
	echo "<hl>Listado del directorio $1</hl>"
	echo "<ul>"
	find $1 -type f,d | while read f
	do
		if [ -d $f ];
		then
			echo "<ul>"
			echo "<li><strong>$(readlink -f $f)</strong></li>"
			busquedacarpetas $f
			echo "</ul>"
		elif [ -f $f ];
		then 
			echo "<li>$(readlink -f $f)</li>"
		fi
	done
	echo "</ul>"
	echo "</body>"
	echo "</html>"
}
creacionhtml $1 > fichero.html
