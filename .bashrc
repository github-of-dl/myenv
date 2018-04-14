# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# disbale flow control (ctrl-S ctrl-Q)
if [ -t 0 ] # avoid error message 'stty: standard input: Invalid argument' when executed within interactive shell, 
then
	stty -ixon

	# disable readline-argument / alt-numkey
	bind -r '\e-'
	bind -r '\e0'
	bind -r '\e1'
	bind -r '\e2'
	bind -r '\e3'
	bind -r '\e4'
	bind -r '\e5'
	bind -r '\e6'
	bind -r '\e7'
	bind -r '\e8'
	bind -r '\e9'
fi

# User specific aliases
alias mk='make'
alias rm='rm -i'
alias mysqlzyj='/usr/local/mysql/bin/mysql -uroot -plinekong'
alias ls='ls --color=auto'
alias bc='bc -l'   # enable floating
alias callme="paplay ${HOME}/local/sounds/Positive.ogg"
alias sh='/bin/bash' # `sh` in ubuntu means `dash` which does not support 'declare -a'
if [ -x "$HOME/.local/vim/bin/vim" ]
then
	alias vim='$HOME/.local/vim/bin/vim'
fi



# User specific functions
if [ -d ~/.bash_func.d ]
then
	#files=`ls ~/.bash_func.d/*.func`
	files=`find ~/.bash_func.d/ -name '*.func'`
	for f in $files
	do
		. $f
	done
fi


# User specific functions
function is_project()
{
	local curpath=`pwd`
	while [ ! -f ${curpath}/${PROJECT_FILE} ]
	do
		if [ ${curpath} = '/' ]
		then
			return 1
		fi
		curpath=`dirname ${curpath}`
	done
	return 0
}
export -f is_project

function project_root_path()
{
	local curpath=`pwd`
	while [ ! -f ${curpath}/${PROJECT_FILE} ]
	do
		if [ ${curpath} = '/' ]
		then
			echo ""
			return 1
		fi
		curpath=`dirname ${curpath}`
	done
	echo ${curpath}
	return 0
}
export -f project_root_path

function change_to_project_root_path()
{
	path=`project_root_path`
	if [ -z "${path}" ]
	then
		return 1
	fi
	cd ${path}
	return 0
}
export -f change_to_project_root_path



