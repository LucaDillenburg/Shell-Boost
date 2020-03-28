#!/bin/bash

. $(dirname "$0")/*.sh

# first index of the array is 1
DIRECTORIES_HISTORY=($(pwd))
INDEX_CURR_DIR=1
FORWARD_LENGTH=0

alias to='cd'

function cd {
	builtin cd $* 2> /tmp/Error
	_error=$(</tmp/Error) # The shell recognizes this and doesn't have to run 'cat' /tmp/ERROR to get the data.
	# ret_cd=$?

	if [[ -z $_error ]]; then
		if ! [[ $(pwd) == $DIRECTORIES_HISTORY[$INDEX_CURR_DIR] ]]; then
			INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + 1`
			DIRECTORIES_HISTORY[$INDEX_CURR_DIR]=$(pwd)

			FORWARD_LENGTH=0
		fi
	else
		__echo_error $_error
		#__echo_error ${error:9}
	fi
	# return $ret_cd
}

function back {
	if [[ $(__check_args_length $*) == error ]] return 1

	amnt_iterations=$(__get_amnt_iterations $*)
	if [[ $amnt_iterations == error ]] return 2
	
	index_cur_after_all_iterations=`expr $INDEX_CURR_DIR - $amnt_iterations`
	if [[ $index_cur_after_all_iterations -lt 1 ]]; then
		__print_msg_no_directories "back"
		return
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR - $amnt_iterations`
	FORWARD_LENGTH=`expr $FORWARD_LENGTH + $amnt_iterations`
	__goto_virtually_curr_dir
}

function fwd {
	if [[ $(__check_args_length $*) == error ]] return 1

	if [[ $1 == -a ]] || [[ $1 == --all ]]; then
		amnt_iterations=$FORWARD_LENGTH
	else
		amnt_iterations=$(__get_amnt_iterations $*)
		if [[ $amnt_iterations == error ]] return 2
	fi

	if [[ $FORWARD_LENGTH -lt `expr $amnt_iterations` ]]; then
		__print_msg_no_directories "forward"
		return
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + $amnt_iterations`
	FORWARD_LENGTH=`expr $FORWARD_LENGTH - $amnt_iterations`
	__goto_virtually_curr_dir
}

function __goto_virtually_curr_dir {
	builtin cd $DIRECTORIES_HISTORY[$INDEX_CURR_DIR]
}

function __check_args_length {
	if [[ $# -gt 1 ]]; then 
		__print_msg_too_many_args
		echo error
	fi
}
function __get_amnt_iterations {
	if [[ -z $1 ]]; then
		echo 1
	elif ! [[ $1 =~ '^[0-9]$' ]] || [[ $1 -eq 0 ]]; then
		__print_msg_invalid_args
		echo error
	else
		echo $1
	fi
}

function __print_msg_invalid_args {
	__echo_error "Invalid arguments."
}
function __print_msg_too_many_args {
	__echo_error "Too many arguments."
}
function __print_msg_no_directories {
	__echo_error "No more directories "$1"."
}
function __echo_error {
	1>&2 echo -e $*"\033[1m ¯\_(ツ)_/¯ \033[0m"
}