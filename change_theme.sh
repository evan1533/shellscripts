#!/bin/bash

file=/home/evan1533/themes.txt

# while IFS= read -r line;
# do
# 	wal --theme $line
# 	sleep 0.5
# done < $file
while IFS= read -r line
do
	#outp=$(wal --theme $line)
	wal --theme $line
	#theme=$(echo $outp | grep -Po "[^ ]*[.]json" | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')
	#echo $outp
	#echo $theme
	echo $line
	read -p "Good? (Y/n): " resp < /dev/tty
	if [ $resp == "y" ] || [ $resp == "Y" ];
	then
		echo "writing"
		echo $line >> /home/evan1533/good_themes.txt
	fi
done < $file
