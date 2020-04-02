#!/bin/bash

SH_NAV_HOME=""
function __set_sh_nav_home {
	SH_NAV_HOME=$(pwd)
	relative_dir=$(dirname $0)
	beginning="${relative_dir:0:2}"
	if [[ $beginning == "./" ]]; then
		relative_dir=${relative_dir:2}
	fi
	if ! [[ $relative_dir == "." ]]; then
		SH_NAV_HOME="$SH_NAV_HOME/$relative_dir"
	fi
}
__set_sh_nav_home

echo "Shell Navigation Home: $SH_NAV_HOME"

source $SH_NAV_HOME/bin/utils.sh

#################################################
# functions
#################################################

function __get_default_shell {
	search_prefix="$USER:/usr/bin/" 2> /dev/null
	prefix_length=${#search_prefix} 2> /dev/null
	grep_search=$(grep "$search_prefix.*$" /etc/passwd) 2> /dev/null
	default_shell=${grep_search##*/} 2> /dev/null
	echo $default_shell
}

function __write_to_file {
	file=$1
	lines=$*

	_error=""
	first=true
	for line in $*; do
		if [[ first==true ]]; then
			__echo_error "Line: $line --- to file: $file"
			
		fi
		first=false
	done
	echo $_error
}

function __install_to_shell {
	shell_file=$1

	line1=" "
	line2="# ShellNavigationBoost installation (do not delete the following lines)"
	line3="SH_NAV_HOME=$SH_NAV_HOME"
	line4="source \"\$SH_NAV_HOME/bin/index.sh\""
	line5=" "

	if ! [[ -z $shell_file ]]; then
		{
			echo $line1 >> "$shell_file"
			echo $line2 >> "$shell_file"
			echo $line3 >> "$shell_file"
			echo $line4 >> "$shell_file"
			echo $line5 >> "$shell_file"
		} 2> /tmp/Error
		_error="$(</tmp/Error)"
	else
		echo $line1
		echo $line2
		echo $line3
		echo $line4
		echo $line5
	fi
}

#################################################
# main
#################################################

chmod +x bin/index.sh
chmod +x update.sh

default_shell=$(__get_default_shell)

installed_in_default_shell=false
shells=("bash" "zsh")
init_shell_files=("$HOME/.bashrc" "$HOME/.zshrc")

for ((i=0; $i<${#shells[@]}; i=`expr $i + 1`)); do
	init_shell_file=${init_shell_files[$i]}
	if [ -e $init_shell_file ]; then
		_error=$(__install_to_shell $init_shell_file)

		if ! [[ -z $_error ]]; then
			1>&2 echo "\033[0;31m[ERROR] Error while appending commands to $init_shell_file:\033[0m"
			1>&2 echo "    $_error"
		else
			cur_shell=${shells[$i]}
			echo "[INFO] Successfully installed in $cur_shell (appended to $init_shell_file)"
			if [[ $default_shell == $cur_shell ]]; then
				installed_in_default_shell=true
			fi
		fi
	fi
done

if [[ $installed_in_default_shell == true ]]; then
	echo -e "\033[1mSuccessfully installed\033[0m"
	source $SH_NAV_HOME/bin/index.sh 
else
	echo -e "\033[1m[Attention!!] Unsuccessful instalation!\033[0m"
	echo -e "\033[1mPlease add the following lines to the ~/.bashrc equivalent file.\033[0m"
fi

__update_content_last_update_file
