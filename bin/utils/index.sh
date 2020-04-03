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

######################################################################

source $SH_NAV_HOME/bin/utils/constants.sh
source $SH_NAV_HOME/bin/utils/custom_echo.sh
source $SH_NAV_HOME/bin/utils/general.sh
source $SH_NAV_HOME/bin/utils/git.sh
