#!/bin/zsh
DOTFILE_DIR="$HOME/dotfiles"
OUT_TO_FILE=0
setopt nullglob

# Create a symbolic link between two files,
# one located in the dotfiles git repo and 
# the other anywhere on disk
#
# Create a link to TARGET with the name LINK_NAME
#
# Parameters
# ----------
# $1 : target file
#       The file located in the dotfile directory that is going
#       to be linked to
# $2 : link name
#       This is the location that the link will be placed
function link_files () {
    if [ $# -ne 2 ]
    then
        exit 1
    fi
    local target_file="$1"
    local link_file="$2"

    differences=$(diff $link_file $target_file)
    if [ ${#differences} -ne 0 ]
    then 
        printf "Err: files are not the same\n\nOutput of 'diff %s %s':\n%s" $link_file $target_file $differences
        exit 1
    fi

    if [ -f $link_file ] && [ ! -L $link_file ]
    then
        if [ $OUT_TO_FILE -eq 0 ]
        then
            echo -e "\e[1;36m${link_file}\e[0m -> ${target_file}"
            rm $link_file
            ln -s $target_file $link_file
        else
            printf "%-47s\t->\t%s\n" ${link_file} ${target_file} >> ~/dotfiles/file_list.txt
        fi
    fi
        
}

function link_directory () {
    if [ $# -ne 1 ]
    then
        exit 1
    fi
    local DIRNAME="$1"
    #printf "%s\n" $DIRNAME
    local SUBDIR_NAME=${DIRNAME#/home/evan1533/dotfiles}
    local RELATIVE_DIR=$HOME$SUBDIR_NAME

    for f in $DIRNAME/{.*,*}
    do
        if [ -f $f ]
        then
            file_name=${f##*/}
            if [ $file_name != "file_list.txt" ] 
            then 
                #printf "%s:\n" $file_name
                link_files "$f" "$RELATIVE_DIR/$file_name"
            fi
        elif [ -d $f ] && [ ${f##*/} != ".git" ]
        then
            #printf "\n\nEntering: %s\n" $f
            link_directory $f
            #printf "\n"
        fi
    done
}

if [ "$1" = "--mock" ]
then
    OUT_TO_FILE=1
    cat /dev/null > ~/dotfiles/file_list.txt
fi

link_directory $DOTFILE_DIR
