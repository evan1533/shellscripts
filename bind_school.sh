#!/bin/zsh

SCHOOL_DIR=/mnt/qnas/evan1533/School
DEST=/home/evan1533

for dir in $SCHOOL_DIR/*
do
    folder_name=${dir##*/}
    if [[ ! -d "$DEST/$folder_name" ]]
    then
        mkdir $DEST/$folder_name
    fi
    is_empty=$([ "$(ls -A $DEST/$folder_name)" ] && echo 0 || echo 1)
    if [ $is_empty -eq 1 ]
    then
        sudo mount --bind $dir $DEST/$folder_name
    else
        echo "Cannot mount to $DEST/$folder_name, directory not empty"
    fi
done
