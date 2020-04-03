#!/bin/bash

function __get_repo_url {
	echo "https://github.com/LucaDillenburg/Shell-Navigation-Boost"
}

function __echo_repo_link {
	echo $(__link $(__get_repo_url) $(__get_repo_url))
}
