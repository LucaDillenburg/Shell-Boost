#!/bin/bash

function __updated_commands_resume {
	echo $(__bold "New commands created:")
	__echo_with_tab "- $(__bold "gac") -> git add all and commit with the message writen next"
	__echo_with_tab "- $(__bold "gst") -> git status"
	__echo_with_tab "- $(__bold "glg") -> git log"
	__echo_with_tab "- $(__bold "gpm") -> git push origin master"
}

function __ask_show_all_commands {
	printf "Do you want to see all commands? [Y/n] "
	read -r response
	if ! [[ $response == "n" || $response == "N" ]]; then
		__all_commands_resume
	fi
}

function __all_commands_resume {
	echo $(__bold "Available aliases:")
	echo " "
	echo $(__bold "# General aliases")
	__echo_with_tab "- $(__bold "c") -> clear screen"
	__echo_with_tab "- $(__bold "..") -> cd .."
	__echo_with_tab "- $(__bold "ee") -> exit terminal"
	__echo_with_tab "- $(__bold "untar [FILE]") -> untar .tar[.gz] file"
	echo " "
	echo $(__bold "# Git")
	__echo_with_tab "- $(__bold "gac [COMMIT-MESSAGE]") -> stages all of the files in the current directory and commit with the message passed by argument"
	__echo_with_tab "- $(__bold "gst") -> git status"
	__echo_with_tab "- $(__bold "glg") -> git log"
	__echo_with_tab "- $(__bold "gpm") -> git push origin master"

	echo " "
	echo $(__bold "Available commands:")
	__echo_with_tab "- $(__bold "back") -> navigate backwards in the directory history"
	__echo_with_tab "- $(__bold "fwd")  -> navigate forward in the directory history"
	__echo_with_tab "- $(__bold "mkcd") -> create directory and navigate to it"
	echo "For more information about this commands execute \"command-name --help\"."
}

function __echo_with_tab {
	echo "   $*"
}