#!/bin/bash
# deploy


dir=`dirname $0`

#----prepare
mkdir -p $HOME/local/bin/

#----install
#vim
cp -vrf ${dir}/.vimrc $HOME/.vimrc
cp -vrf ${dir}/.vim $HOME/

#inputrc
cp -vrf ${dir}/.inputrc $HOME/.inputrc

#bashprofile
cp -vrf ${dir}/.bash_profile ${HOME}/
cp -vrf ${dir}/.bashrc $HOME
cp -vrf ${dir}/.bash_func.d $HOME/

#session_mgr
cp -vrf ${dir}/.session_tag_cfg $HOME/

#git
cp -vrf ${dir}/.gitconfig $HOME/.gitconfig


#local
cp -vrf ${dir}/local $HOME

#c
cd c
make all
cp -f bin/* $HOME/local/bin/
cd -
