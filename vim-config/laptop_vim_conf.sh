#!/bin/bash

# sudo apt remove vim vim-runtime gvim

./configure --enable-fail-if-missing \
            --with-features=huge \
            --with-x \
            --x-includes=/usr/include/X11 \
            --x-libraries=/usr/lib \
            --enable-multibyte \
            --enable-gnome-check \
            --enable-gui=auto \
            --enable-fontset \
            --enable-terminal \
            --enable-cscope \
            --enable-rubyinterp=yes \
            --enable-python3interp=yes \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --with-compiledby=evan1533 \
            --with-python3-config-dir=$(python3-config --configdir) \
            --with-lua-prefix=/usr/include/lua5.2 \
            --prefix=/usr \
 && make VIMRUNTIMEDIR=/usr/share/vim/vim82


VERSION=`git describe --tags --abbrev=0 HEAD`
sudo checkinstall --pkgname 'vim' --pkgversion '${VERSION#v}' --pkgrelease '8' --pkgsource 'https://github.com/vim/vim' --provides 'vim'
