#!/bin/bash

if [ $# -gt 0 ]
then
    ssh $1 "mkdir -p ~/.terminfo/x/; printf 'PATH=\$PATH:~/.terminfo/x/\n' >> ~/.profile"
    infocmp xterm-kitty | ssh $1 tic -x -o \~/.terminfo /dev/stdin
    scp /usr/share/terminfo/x/xterm-kitty $1:~/.terminfo/x/
else
    echo "Please specify host"
fi
