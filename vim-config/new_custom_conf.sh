#!/bin/bash

# sudo apt remove vim vim-runtime gvim

sudo apt build-dep -y vim-gtk
sudo apt install -y python3

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
 && make distclean \
 && make VIMRUNTIMEDIR=/usr/local/share/vim/vim82 -j$(nproc) \
 && make install


# VERSION=`git describe --tags --abbrev=0 HEAD`
# sudo checkinstall --pkgname 'vim' --pkgversion '${VERSION#v}' --pkgrelease '8' --pkgsource 'https://github.com/vim/vim' --provides 'vim'

VIM=`which vim`
sudo update-alternatives --install /usr/bin/vim vim $VIM 90
sudo update-alternatives --install /usr/bin/vi vi $VIM 90
sudo update-alternatives --install /usr/bin/editor editor $VIM 90
