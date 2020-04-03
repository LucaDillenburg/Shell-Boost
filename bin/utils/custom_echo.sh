#!/bin/bash

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
