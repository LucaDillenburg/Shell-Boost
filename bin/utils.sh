#!/bin/bash

# utils
function __is_option {
	if [[ $1 =~ '^-' ]] && ! [[ $(__is_negative_num $1) == true ]]; then
		echo true
	else
		echo false
	fi
}
function __is_num {
	if [[ $1 =~ '^-*[0-9]+$' ]] ; then
		echo true
	else
		echo false
	fi
}
function __is_positive_num {
	if [[ $1 =~ '^[0-9]+$' ]] ; then
		echo true
	else
		echo false
	fi
}
function __is_negative_num {
	if [[ $1 =~ '^-[0-9]+$' ]] ; then
		echo true
	else
		echo false
	fi
}

# echo
function __link {
	echo -e "\e]8;;$2\e\\$1\e]8;;\e\\"
}
function __bold {
	echo -e  "\033[1m$1\033[0m"
}
function __echo_error {
	1>&2 echo -e $*
}