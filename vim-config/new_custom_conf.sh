#!/bin/bash

# [[ $(dpkg -l | grep vim | wc -l) -gt 0 ]] && sudo apt remove vim vim-runtime gvim

VIMSRCDIR=~/.local/src/vim
PYTHON3CMD=$(python3 --version | tr "[:upper:]" "[:lower:]" | tr -d "[:blank:]" | grep -Po "^python3\.\d")

sudo apt build-dep -y vim-gtk
sudo apt install -y python3

# Lua stuff
# sudo apt install liblua5.2-dev
# [[ ! -d /usr/include/lua5.2/include ]] && mkdir /usr/include/lua5.2/include || cp -r /usr/include/lua5.2/*.* /usr/include/lua5.2/include/ || exit 1
# [[ ! -L /usr/local/lib/liblua.so ]] || mv /usr/local/lib/liblua.so /usr/local/lib/liblua.so.old && sudo ln -s /usr/lib/x86_64-linux-gnu/liblua5.2.so /usr/local/lib/liblua.so || exit 1


cd $VIMSRCDIR
git pull

make clean distclean

./configure --with-compiledby=evan1533 \
            --with-features=huge \
            --with-x \
            --enable-multibyte \
            --enable-gui=auto \
            --enable-fontset \
            --enable-terminal \
            --enable-cscope \
            --enable-python3interp=yes \
            --with-python3-config-dir=$(${PYTHON3CMD}-config --configdir) \
            --enable-luainterp=yes \
            --with-lua-prefix=/usr/include/lua5.2 \
            --enable-perlinterp=yes \
            --enable-rubyinterp=yes \
            --enable-fail-if-missing \
            --enable-largefile \
            --prefix=/usr/local \
 && make distclean \
 && make VIMRUNTIMEDIR=/usr/local/share/vim/vim82 -j$(nproc) \
 && make install

if [[ $? -eq 0 ]]
then
    VIM=`which vim`
    sudo update-alternatives --install /usr/bin/vim vim $VIM 90
    sudo update-alternatives --install /usr/bin/vi vi $VIM 90
    sudo update-alternatives --install /usr/bin/editor editor $VIM 90
fi

# VERSION=`git describe --tags --abbrev=0 HEAD`
# sudo checkinstall --pkgname 'vim' --pkgversion '${VERSION#v}' --pkgrelease '8' --pkgsource 'https://github.com/vim/vim' --provides 'vim'
