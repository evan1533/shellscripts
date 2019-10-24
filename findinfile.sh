#!/bin/bash

text=$1
DIRECTORY=$2

if [ -d "${DIRECTORY}" ]; then

	for file in $DIRECTORY/*;
	do
		if [ -f "${file}" ]; then
			# echo "Searching for $text in $file"
			grep_res=$(cat $file | grep "$text")
			if [ -n "$grep_res" ]; then
				echo "$file"
				echo "    $grep_res"
				fi
	fi
	done
else
	echo "$DIRECTORY is not a directory"
fi
