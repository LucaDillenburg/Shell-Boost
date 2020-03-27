#!/bin/bash

. $(dirname "$0")/auxiliar.sh

# first index of the array is 1
DIRECTORIES_HISTORY=($(pwd))
INDEX_CURR_DIR=1
FORWARD_LENGTH=0

function go {
	cd $1

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