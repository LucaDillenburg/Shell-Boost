#!/bin/bash

function __check_new_version_git {
	initial_directory=$(pwd)

	builtin cd $(__get_project_path) 2> /tmp/Error
	_error=$(</tmp/Error)

	if ! [[ -z $_error ]]; then
		__echo_error "Shell Navigation Boost directory have changed. Please update \$SH_NAV_HOME ~/.bashrc or the equivalent."
		return 400
	else
		response=$(git pull origin master 2> /tmp/Error)
		_error=$(</tmp/Error)

		if ! [[ -z $($_error) ]]; then
			if ! [[ -z $($($_error) | "grep files would be overwritten by merge") ]]; then
				__echo_error "Failed to update Shell Navigation Boost. You can do this by removing this folder and cloning again at $(__echo_repo_link) into the same path."
				__echo_error "Project home folder: $(__get_project_path)"
				# git pull conflict (permanent) - this should never happen
			else
				# no internet connection or other issues (not permanent)
			fi
		else
			if ! [[ -z $($response | grep "Updating") ]]; then
				echo "Shell Navigation Boost was updated. Please, feel free to contribute at $(__echo_repo_link)."
			fi
		fi
	fi

	cd $initial_directory
}

function __get_repo_url {
	echo "https://github.com/LucaDillenburg/Shell-Navigation-Boost"
}
function __echo_repo_link {
	echo $(__link $(__get_repo_url) $(__get_repo_url))
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

function __link {
	echo -e "\e]8;;$2\e\\$1\e]8;;\e\\"
}
function __bold {
	echo -e  "\033[1m$1\033[0m"
}
function __echo_error {
	1>&2 echo -e $*
}