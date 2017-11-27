# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
        . ~/.bashrc
fi

#NEW_GCC_4_8_5=$HOME/local/gcc
export LD_LIBRARY_PATH=.:/usr/local/lib/:/usr/local/gcc-4.3.5/lib/:/usr/local/mysql/lib:$HOME/local/bin
#export LD_LIBRARY_PATH=.:${NEW_GCC_4_8_5}/lib/:${NEW_GCC_4_8_5}/lib64:/usr/local/lib/:/usr/local/mysql/lib:$HOME/local/bin

# User specific environment and startup programs

declare -x LS_COLORS='no=00:fi=00:di=00;34:ln=00;36:pi=40;33:so=00;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;32:*.cmd=00;32:*.exe=00;32:*.com=00;32:*.btm=00;32:*.bat=00;32:*.sh=00;32:*.csh=00;32:*.tar=00;31:*.tgz=00;31:*.arj=00;31:*.taz=00;31:*.lzh=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bz=00;31:*.tz=00;31:*.rpm=00;31:*.cpio=00;31:*.jpg=00;35:*.gif=00;35:*.bmp=00;35:*.xbm=00;35:*.xpm=00;35:*.png=00;35:*.tif=00;35:'
#PATH=${NEW_GCC_4_8_5}/bin:$PATH:$HOME/local/bin
PATH=$PATH:$HOME/local/bin
export PATH

export LANG=en_US.utf8
#export LANG=zh_CN
#export LC_ALL=zh_CN.gbk
#export LC_CTYPE=zh_CN.gbk
#export CDPATH=~/projects/z3/card/program/trunk/


#svn editor
export SVN_EDITOR=vim

#grep option 
export GREP_OPTIONS="--binary-files=without-match "

ulimit -c 1000000
ulimit -n 4090


export GOROOT=/home/wdl/local/matual/go
export PATH=$PATH:$GOROOT/bin
export GOPATH=$HOME/program/go

#python
export PYTHONPATH=$HOME/.vim/python


#git
export GIT_EDITOR=vim
