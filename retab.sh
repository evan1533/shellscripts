#!/bin/bash

if [ $# -lt 2 ]
  then
    echo "ERROR: No arguments provided"
elif [ -z "$1" ] || [ -z "$2" ]
  then
    echo "ERROR: Please specify filenames"
else
	sed -e 's/\t/   /g' $1 > $2
fi
