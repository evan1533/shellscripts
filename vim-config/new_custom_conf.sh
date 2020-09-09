#!/bin/sh

# sudo apt remove vim vim-runtime gvim

./configure --enable-fail-if-missing \
            --with-compiledby=evan1533 \
            --with-features=huge \
            --with-x \
            --enable-multibyte \
            --enable-gui=auto \
            --enable-fontset \
            --enable-terminal \
            --enable-cscope \
            --enable-python3interp=yes \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-rubyinterp=yes \
            --with-python3-config-dir=$(python3-config --configdir) \
            --prefix=/usr/local \
 && make VIMRUNTIMEDIR=/usr/local/share/vim/vim82 -j8

sudo checkinstall --pkgname 'vim' --pkgversion '8.2.1567' --pkgrelease '2' --pkgsource 'https://github.com/vim/vim' --provides 'vim'
