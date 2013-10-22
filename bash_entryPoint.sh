#!/usr/bin/env bash


SCRIPTS_BASE_DIR=${1:-"$HOME/dev/shell_scripts"}
export SCRIPTS_BASE_DIR


#GLOBAL SETTINGS
LANGUAGE="en_US"
LANG="en_US"
LC_ALL=C




##################
#entry points
##################


#1. load aliases
#source ~/dev/shell_scripts/aliases.sh
source $SCRIPTS_BASE_DIR/aliases.sh 



#2. 
if [ $HOSTNAME == "belltown" ]
then
    source $SHELL_DIR/load_modules.sh
fi


#3. shell utilities functions
source $SCRIPTS_BASE_DIR/SGE_functions.sh











