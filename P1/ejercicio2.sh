#!/bin/bash
if [ $# == 1 ];
then
	let tamano=0
else
	let tamano=$2-1
fi
find $1 -size +$tamano | while read f
do
	echo "
