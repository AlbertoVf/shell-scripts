#!/bin/sh

# Change the visibility of a file.
visibility() {
	if [ ${1:0:1} = "." ]; then
		file=${1:1}
	else
		file=".$1"
	fi
	mv $1 $file
}
