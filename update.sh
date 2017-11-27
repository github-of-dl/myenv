#!/bin/bash
# update


dir=`dirname $0`

#vim
cp -vrf $HOME/.vimrc ${dir}/
cp -vrf $HOME/.vim ${dir}/

#inputrc
cp -vrf $HOME/.inputrc ${dir}/

#bashprofile
cp -vrf $HOME/.bash_profile ${dir}/
cp -vrf $HOME/.bashrc ${dir}/

#git
cp -vrf $HOME/.gitconfig ${dir}/


#local/bin
cp -vrf $HOME/local/bin ${dir}/local/
