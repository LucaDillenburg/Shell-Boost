#!/bin/bash

. $(dirname "$0")/*.sh

# first index of the array is 1
DIRECTORIES_HISTORY=($(pwd))
INDEX_CURR_DIR=1
FORWARD_LENGTH=0

alias to='cd'

function cd {
	__single_cd $1
}
function __single_cd {
	if [ ! -d $1 ]; then
		1>&2 echo "cd: no such file or directory: $1"
	elif [ ! -x $1 ]; then
		1>&2 echo "cd: permission denied: $1"
	else
		builtin cd $1
		__update_dir_history
	fi	
}

function __update_dir_history {
	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + 1`
	DIRECTORIES_HISTORY[$INDEX_CURR_DIR]=$(pwd)

	FORWARD_LENGTH=0
}

function back {
	amnt_iterations=1
	index_cur_after_all_iterations=`expr $INDEX_CURR_DIR - $amnt_iterations`
	if [[ $index_cur_after_all_iterations -lt 1 ]]; then
		__print_msg_no_directories "back"
		return
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR - 1`
	FORWARD_LENGTH=`expr $FORWARD_LENGTH + 1`
	__goto_virtually_curr_dir
}

function forward {
	if [[ $FORWARD_LENGTH -le 0 ]]; then
		__print_msg_no_directories "forward"
		return
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + 1`
	echo $INDEX_CURR_DIR
	FORWARD_LENGTH=`expr $FORWARD_LENGTH - 1`
	__goto_virtually_curr_dir
}