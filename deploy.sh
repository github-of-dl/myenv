#!/bin/bash
# deploy

# ===================config=========================
LOCAL_DIR=$HOME/.local/
DEPLOY_TMP_DIR=deploy_tmp_dir


#----------------------prepare-----------------------
mkdir -p ${LOCAL_DIR}
rm -rf  ${DEPLOY_TMP_DIR}
mkdir -p ${DEPLOY_TMP_DIR}
for f in `ls`
do
	if [ $f != ${DEPLOY_TMP_DIR} ]
	then
		cp -rfv $f ${DEPLOY_TMP_DIR}/
	fi
done


#----------------------replace configs---------------
. config.sh
files=`find  ${DEPLOY_TMP_DIR} -path '*/local/bin/*' -o -name '*.py'`
for f in $files
do
	echo "replace configs with file $f"
	sp "replace_in_file('$f', 'REP_REDMINE_LOGIN_PAGE', '${REP_REDMINE_LOGIN_PAGE}')"
	sp "replace_in_file('$f', 'REP_REDMINE_USERNAME', '${REP_REDMINE_USERNAME}')"
	sp "replace_in_file('$f', 'REP_REDMINE_PASSWORD', '${REP_REDMINE_PASSWORD}')"
	sp "replace_in_file('$f', 'REP_REDMINE_MINE', '${REP_REDMINE_MINE}')"
	sp "replace_in_file('$f', 'REP_REDMINE_TRACE', '${REP_REDMINE_TRACE}')"
done

#----------------------install-----------------------
#vim
cp -vrf ${DEPLOY_TMP_DIR}/vimrc $HOME/.vimrc
rm -rf $HOME/.vim
cp -vrf ${DEPLOY_TMP_DIR}/vim $HOME/.vim

#inputrc
cp -vrf ${DEPLOY_TMP_DIR}/.inputrc $HOME/.inputrc

#bashprofile
cp -vrf ${DEPLOY_TMP_DIR}/.bash_profile ${HOME}/
cp -vrf ${DEPLOY_TMP_DIR}/.bashrc $HOME
#cp -vrf ${DEPLOY_TMP_DIR}/.bash_func.d $HOME/

#session_tag
cd session_tag/
sh install.sh
cd -

#git
cp -vrf ${DEPLOY_TMP_DIR}/.gitconfig $HOME/.gitconfig


#local
cp -vrf ${DEPLOY_TMP_DIR}/local/* ${LOCAL_DIR}

#c
cd c
make all
cp -vrf bin ${LOCAL_DIR}/
cd -

#tmux
cp -vrf .tmux.conf .tmux ${HOME}


#--------------------install python----------------
mkdir -p ${LOCAL_DIR}/python
cp -vrf ${DEPLOY_TMP_DIR}/python/dlutils.py ${LOCAL_DIR}/python/
