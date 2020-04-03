#!/bin/bash

function __echo_cd_help {
	echo -e "Usage: cd DIRECTORY"
	echo -e "Navigate to the DIRECTORY, if it exist and you have the right permissions."
    echo -e "	-h, --help 	display this help"
	__echo_check_our_repo
}

function __echo_back_help {
	echo -e "Usage: back [OPTION]"
	echo -e "Navigate backwards in the directory history."
	echo -e "	-n=NUMBER	navigate NUMBER times backwards"
    echo -e "	-h, --help 	display this help"
	__echo_check_our_repo
}

function __echo_fwd_help {
	echo -e "Usage: fwd [OPTION]..."
	echo -e "Navigate forward in the directory history."
	echo -e "	-n=NUMBER	navigate NUMBER times forward"
	echo -e "	-a, --all	navigate forward until the last directory in the history"
    echo -e "	-h, --help 	display this help"
	__echo_check_our_repo
}

function __echo_mkcd_help {
	echo -e "Usage: mkcd DIRECTORY."
	echo -e "Create directory and navigate to it."	
    echo -e "	-h, --help 	display this help"
	__echo_check_our_repo
}

function __echo_check_our_repo {
	repo_url=$(__get_repo_url)
	echo "Please, don't forget to check out our repo at $(__link $repo_url $repo_url)"
}