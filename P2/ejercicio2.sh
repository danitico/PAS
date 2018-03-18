#!/bin/bash
if [ $# != 1 ]; then
	echo "Se ha llamado mal al programa. Se necesita pasar el fichero por línea de argumentos"
	exit
fi
cat $1 | sed -r '/^\s*$/d; /^=*$/d; /^[[:space:]]/d; s/^\((.*)\)[[:space:]].*$/|-> Fecha de Estreno: \1/; s/^Reparto.(.*)/|-> Reparto: \1/; s/^Dirigida.por.(.*)/|-> Director: \1/; s/(^[1-9]hr.*)/|-> Duración: \1/; s/(^[^|].*)/Título: \1/'
