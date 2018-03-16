#!/bin/bash
cat /proc/cpuinfo | grep -E '^model name' | uniq | sed -r -e 's/model.name.*:.(.*)/Modelo de procesador: \1/'
cat /proc/cpuinfo | grep -E '^cpu MHz' | sed -n -e '1p' | sed -r -e 's/cpu.MHz.*:.(.*)/Megahercios: \1/'
cat /proc/cpuinfo | grep -E 'siblings' | sed -n -e '1p' | sed -r -e 's/siblings.*:.(.*)/Número de hilos máximo de ejecución: \1/'
