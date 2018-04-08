# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi


# User specific environment and startup programs

export LD_LIBRARY_PATH=.:/usr/local/lib/:/usr/local/gcc-4.3.5/lib/:/usr/local/mysql/lib

export PATH=$PATH:$HOME/.local/bin

export LANG=en_US.utf8
#export LANG=zh_CN
#export LC_ALL=zh_CN.gbk
#export LC_CTYPE=zh_CN.gbk
#export CDPATH=~/projects/z3/card/program/trunk/


#svn/git editor
export SVN_EDITOR=vim
export GIT_EDITOR=vim

ulimit -c 1000000
ulimit -n 4090


export GOROOT=${HOME}/local/matual/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/program/go

#python
export PYTHONPATH=$HOME/.vim/python

#project.xml
export PROJECT_FILE=project.cfg
