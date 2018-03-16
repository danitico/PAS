#!/bin/bash
cat /proc/cpuinfo | grep -E '^model name' | uniq | sed -r -e 's/model.name.*:.(.*)/Modelo de procesador: \1/'
cat /proc/cpuinfo | grep -E '^cpu MHz' | sed -n -e '1p' | sed -r -e 's/cpu.MHz.*:.(.*)/Megahercios: \1/'
cat /proc/cpuinfo | grep -E 'siblings' | sed -n -e '1p' | sed -r -e 's/siblings.*:.(.*)/Número de hilos máximo de ejecución: \1/'
cat /proc/cpuinfo | grep -E 'cache size' | uniq | sed -r -e 's/cache.size.*:.(.*)/Tamaño de caché: \1/'
cat /proc/cpuinfo | grep -E 'vendor_id' | uniq | sed -r -e 's/^vendor_id.*:.(.*)/ID vendedor: \1/'
echo "Puntos de montaje"
cat /proc/mounts | sed -r -e 's/^(\/*[[:alpha:]]*\/*[[:alpha:]]*_*-*[0-9]*[[:alpha:]]*)[[:space:]](\/*[[:alpha:]]*\/*[[:alpha:]]*_*-*[[:alpha:]]*\/*[0-9]*[[:alpha:]]*\/*[[:alpha:]]*_*[[:alpha:]]*,*[[:alpha:]]*_*[[:alpha:]]*)[[:space:]]([[:alpha:]]*\.*_*[0-9]*[[:alpha:]]*-*[[:alpha:]]*).*/-> Punto de montaje: \2, Dispositivo: \1, Tipo de dispositivo: \3/'
echo "Particiones y número de bloques"
cat /proc/partitions | sed -n '1,2!p' | sed -r -e 's/^[[:space:]]*[0-9]*[[:space:]]*[0-9]*[[:space:]]*([0-9]*)[[:space:]](.*)/-> Partición: \2, Numero Bloques: \1/'
