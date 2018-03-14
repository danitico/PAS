#!/bin/bash
cat ficherosPr2/peliculas.txt | sed -r '/^\s*$/d; /^=*$/d; /^[[:space:]]/d; s/^\((.*)\)[[:space:]].*$/|-> Fecha de Estreno: \1/; s/^Reparto.(.*)/|-> Reparto: \1/; s/^Dirigida.por.(.*)/|-> Director: \1/; s/(^[1-9]hr.*)/Duración: \1/'
cat ficherosPr2/peliculas.txt | sed -r 's/(^[^\(|^\bDirigida\b|^\bReparto\b].*)/Titulo: \1/' # para obtener titulo, la tengo mal :(
