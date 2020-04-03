#!/bin/bash

function __get_absolute_path {
	nonnormalized_path=""
	if ! [[ -z $(grep '^/' <<< $1) ]]; then
		nonnormalized_path=$1
	elif [[ $1 == "~" ]]; then
		nonnormalized_path="$HOME"
	elif ! [[ -z $(grep '^~/' <<< $1) ]]; then
		nonnormalized_path="$HOME/${1:2}"
	else
		nonnormalized_path=$(__relative_to_absolute_path $1)
	fi

	if [[ "${nonnormalized_path: -1}" == "/" ]]; then
		length=${#str}
		echo ${nonnormalized_path:0:`expr $length - 1`}
	else
		echo $nonnormalized_path
	fi
}
function __relative_to_absolute_path {
	echo "$(pwd)/$1"
	# $1 can be "./folder", "../folder", ".",... that it will still work
}

function __today {
	echo $(date)
}

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
