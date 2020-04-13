#!/bin/bash

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
	if ! [[ -f $(__get_file_last_update) ]]; then
		touch $(__get_file_last_update)
		echo $(__today) > $(__get_file_last_update)
		echo $(__today)
	else
		echo $(cat $(__get_file_last_update))
	fi
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

	builtin cd $SH_BOOST_HOME 2> /tmp/Error
	response=$(git pull origin master 2> /tmp/Error)
	_error=$(</tmp/Error)

	if ! [[ -z $(grep "would be overwritten by merge" <<< $_error) ]] ||
		! [[ -z $(grep "Exiting because of an unresolved conflict" <<< $_error) ]]; then
		__echo_error "Failed to update Shell Boost. You can do this by removing this folder and cloning again at $(__echo_repo_link) into the same path."
		__echo_error $(__red "Error: ")
		__echo_error "    $_error"
		__echo_error "Project home folder: $SH_BOOST_HOME"
		# git pull conflict (permanent) - this should never happen
		ret_code=1
	elif ! [[ -z $(grep "Updating" <<< $response) ]]; then
		echo "Shell Boost was updated. Please, feel free to contribute at $(__echo_repo_link)."

		echo " "
		__updated_commands_resume

		echo " "
		__ask_show_all_commands

		echo " "
		echo $(__bold "Please open a new terminal to access the new commands.")
	else
		if [[ $1 == "--verbose" ]]; then
			echo "Nothing to be updated. Shell Boost is already in its most stable version."
			echo "Go check out are git repository for more information: $(__echo_repo_link)"
		fi
	fi

	cd $initial_directory
	return $ret_code
}
