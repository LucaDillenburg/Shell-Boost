#!/bin/bash

source $SH_NAV_HOME/bin/utils.sh
source $SH_NAV_HOME/bin/extra.sh
source $SH_NAV_HOME/bin/commands_help.sh

__git_pull_if_needed

# first index of the array is 1
DIRECTORIES_HISTORY=($(pwd))
INDEX_CURR_DIR=1
FORWARD_LENGTH=0

function cd {
	if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
		__echo_cd_help
		return 0
	fi

	builtin cd $* 2> /tmp/Error
	ret_cd=$?
	_error=$(</tmp/Error) # The shell recognizes this and doesn't have to run 'cat' /tmp/ERROR to get the data.

	if [[ -z $_error ]]; then
		if ! [[ $(pwd) == $DIRECTORIES_HISTORY[$INDEX_CURR_DIR] ]]; then
			INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + 1`
			DIRECTORIES_HISTORY[$INDEX_CURR_DIR]=$(pwd)

			FORWARD_LENGTH=0
		fi
	else
		__echo_error "cd: "${_error:9}
	fi
	return $ret_cd
}

function back {
	if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
		__echo_back_help
		return 0
	fi

	if [[ $# -gt 1 ]]; then 
		__print_msg_too_many_args "back"
		return 1
	fi

	amnt_iterations=$(__get_amnt_iterations "back" $1)
	if [[ $amnt_iterations == error ]] return 2
	
	index_cur_after_all_iterations=`expr $INDEX_CURR_DIR - $amnt_iterations`
	if [[ $index_cur_after_all_iterations -lt 1 ]]; then
		__print_msg_no_directories "back" "backwards"
		return 3
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR - $amnt_iterations`
	FORWARD_LENGTH=`expr $FORWARD_LENGTH + $amnt_iterations`
	__goto_virtually_curr_dir "back" $amnt_iterations
	return 0
}

function fwd {
	if [[ $1 == "--help" ]] || [[ $1 == "-h" ]]; then
		__echo_fwd_help
		return 0
	fi

	if [[ $# -gt 1 ]]; then 
		__print_msg_too_many_args "fwd"
		return 1
	fi

	if [[ $1 == -a ]] || [[ $1 == --all ]]; then
		amnt_iterations=$FORWARD_LENGTH
	else
		amnt_iterations=$(__get_amnt_iterations "fwd" $1)
		if [[ $amnt_iterations == error ]] return 2
	fi

	if [[ $FORWARD_LENGTH -lt `expr $amnt_iterations` ]]; then
		__print_msg_no_directories "fwd" "forward"
		return 3
	fi

	INDEX_CURR_DIR=`expr $INDEX_CURR_DIR + $amnt_iterations`
	FORWARD_LENGTH=`expr $FORWARD_LENGTH - $amnt_iterations`
	__goto_virtually_curr_dir "fwd" $amnt_iterations
	return 0
}

function __goto_virtually_curr_dir {
	cmd=$1;amnt_iterations=$2
	builtin cd $DIRECTORIES_HISTORY[$INDEX_CURR_DIR] 2> /tmp/Error
	_error=$(</tmp/Error) # The shell recognizes this and doesn't have to run 'cat' /tmp/ERROR to get the data.
	if ! [[ -z $_error ]]; then
		__echo_error "$cmd: "${_error:32}
		__echo_error "$(__bold "Suggestion"): run $(__bold "$cmd -n=`expr $amnt_iterations + 1`")"
	fi
}

function __get_amnt_iterations {
	arg=$2;cmd=$1
	if [[ -z $arg ]]; then
		echo 1
	elif [[ $arg =~ '^-n=[0-9]*$' ]]; then
		echo ${arg:3}
	else
		__print_msg_invalid_args $cmd $arg
		echo error
	fi
}

function __print_msg_invalid_args {
	arg=$2;cmd=$1
	if [[ $(__is_option $arg) == true ]]; then
		arg_type=option
	else
		arg_type=argument
	fi
	__echo_error "$cmd: invalid $arg_type $arg"
}
function __print_msg_too_many_args {
	__echo_error "$1: too many arguments"
}
function __print_msg_no_directories {
	__echo_error "$1: Cannot go $2. No more directories in this direction.$(__echo_smile)"
}

function __echo_smile {
	echo -e "  \e]8;;$(__get_repo_url)\e\\¯\_(ツ)_/¯\e]8;;\e\\"
}