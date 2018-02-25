# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# disbale flow control
stty -ixon

# User specific aliases
alias mk='make'
alias rm='rm -i'
alias mysqlzyj='/usr/local/mysql/bin/mysql -uroot -plinekong'
alias ls='ls --color=auto'
alias bc='bc -l'   # enable floating
alias callme="paplay ${HOME}/local/sounds/Positive.ogg"
#alias vim='/home/wdl/local/vim/bin/vim'




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



