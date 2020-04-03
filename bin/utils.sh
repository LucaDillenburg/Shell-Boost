#!/bin/bash

initial_directory=$(pwd)
builtin cd $SH_NAV_HOME 2> /tmp/Error
_error=$(</tmp/Error)
if ! [[ -z $_error ]]; then
	__echo_error "Shell Navigation Boost directory have changed. Please update \$SH_NAV_HOME ~/.bashrc or the equivalent."
	ret_code=400
fi
cd $initial_directory

function __get_data_folder {
	echo "$HOME/.sh_nav_boost_data"
}

if ! [[ -d $(__get_data_folder) ]]; then
	mkdir $(__get_data_folder)
fi

########################################################
# functions
########################################################

function __git_pull_if_needed {
	last_update=$(__get_last_update_date)

	sdate=$(date --date="$last_update" '+%s')
	edate=$(date --date="$(__today)"   '+%s')
	days_between=$(( (edate - sdate) / 86400 ))

	if [[ $days_between -gt 7 ]]; then
		__git_pull
		__update_content_last_update_file 
	fi
}
function __get_last_update_date {
	echo $(cat $(__get_file_last_update))
}
function __update_content_last_update_file {
	file_last_update=$(__get_file_last_update)
	if ! [[ -f "$file_last_update" ]]; then
		touch $file_last_update
	fi
	echo $(__today) > $file_last_update
}
function __get_file_last_update {
	echo "$(__get_data_folder)/.last_update"
}

function __git_pull {
	initial_directory=$(pwd)
	ret_code=0

	builtin cd $SH_NAV_HOME 2> /tmp/Error
	response=$(git pull origin master 2> /tmp/Error)
	_error=$(</tmp/Error)

	if ! [[ -z $(grep "would be overwritten by merge" <<< $_error) ]] ||
		! [[ -z $(grep "Exiting because of an unresolved conflict" <<< $_error) ]]; then
		__echo_error "Failed to update Shell Navigation Boost. You can do this by removing this folder and cloning again at $(__echo_repo_link) into the same path."
		__echo_error $(__red "Error: ")
		__echo_error "    $_error"
		__echo_error "Project home folder: $SH_NAV_HOME"
		# git pull conflict (permanent) - this should never happen
		ret_code=1
	elif ! [[ -z $(grep "Updating" <<< $response) ]]; then
		echo "Shell Navigation Boost was updated. Please, feel free to contribute at $(__echo_repo_link)."
	else
		if [[ $1 == "--verbose" ]]; then
			echo "Nothing to be updated. Shell Navigation Boost is already in its most stable version."
			echo "Go check out are git repository for more information: $(__echo_repo_link)"
		fi
	fi

	cd $initial_directory
	return $ret_code
}



function __get_absolute_path {
	nonnormalized_path=""
	if [[ $1 =~ "^/" ]]; then
		nonnormalized_path=$1
	elif [[ $1 == "~" ]]; then
		nonnormalized_path="$HOME"
	elif [[ $1 =~ "^~/" ]]; then
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

function __get_repo_url {
	echo "https://github.com/LucaDillenburg/Shell-Navigation-Boost"
}
function __echo_repo_link {
	echo $(__link $(__get_repo_url) $(__get_repo_url))
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

function __red {
	echo -e "\033[0;31m$1\033[0m"
}
function __link {
	echo -e "\e]8;;$2\e\\$1\e]8;;\e\\"
}	
function __bold {
	echo -e  "\033[1m$1\033[0m"
}
function __echo_error {
	1>&2 echo -e $*
}