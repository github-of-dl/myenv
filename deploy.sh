#!/bin/bash
# deploy

# ===================config=========================
local_dir=$HOME/.local/


dir=`dirname $0`

#----------------------prepare-----------------------
mkdir -p ${local_dir}

#----------------------install-----------------------
#vim
cp -vrf ${dir}/.vimrc $HOME/.vimrc
cp -vrf ${dir}/.vim $HOME/

#inputrc
cp -vrf ${dir}/.inputrc $HOME/.inputrc

#bashprofile
cp -vrf ${dir}/.bash_profile ${HOME}/
cp -vrf ${dir}/.bashrc $HOME
cp -vrf ${dir}/.bash_func.d $HOME/

#session_tag
cd session_tag/
sh install.sh
cd -

#git
cp -vrf ${dir}/.gitconfig $HOME/.gitconfig


#local
cp -vrf ${dir}/local/* ${local_dir}

#c
cd c
make all
cp -vrf bin ${local_dir}/
cd -

#tmux
cp -vrf .tmux.conf .tmux ${HOME}
