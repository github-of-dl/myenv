#!/bin/bash
# deploy


dir=`dirname $0`

#vim
cp -vrf ${dir}/.vimrc $HOME/.vimrc
cp -vrf ${dir}/.vim $HOME/

#inputrc
cp -vrf ${dir}/.inputrc $HOME/.inputrc


#git
cp -vrf ${dir}/.gitconfig $HOME/.gitconfig


#local
cp -vrf ${dir}/local $HOME
