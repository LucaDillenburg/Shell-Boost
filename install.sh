#!/bin/bash

chmod +x bin/index.sh

relatve_dir=$(dirname $0)
if [[ $relatve_dir == "." ]]; then
	relatve_dir=""
fi
source=$(echo "$(pwd)$relatve_dir")
source_command=";source \"$source/bin/index.sh\"; # ShellNavigationBoost installation"

search_prefix="$USER:/usr/bin/" 2> /dev/null
prefix_length=${#search_prefix} 2> /dev/null
grep_search=$(grep "$search_prefix.*$" /etc/passwd) 2> /dev/null
default_shell=${grep_search##*/} 2> /dev/null

installed_in_default_shell=false
shells=("bash" "zsh")
init_shell_files=("$HOME/.bashrc" "$HOME/.zshrc")
for ((i=0; $i<${#shells[@]}; i=`expr $i + 1`)); do
	init_shell_file=${init_shell_files[$i]}
	if [ -e $init_shell_file ]; then
    	echo "$source_command" >> "$init_shell_file" 2> /tmp/Error
		_error=$(</tmp/Error) # The shell recognizes this and doesn't have to run 'cat' /tmp/ERROR to get the data.

		if ! [[ -z $_error ]]; then
			1>&2 echo "Error while appending commands to $init_shell_file:"
			1>&2 echo "    $_error"
		else
			cur_shell=${shells[$i]}
			echo "Successfully installed in $cur_shell (appended to $init_shell_file)"
			if [[ $default_shell == $cur_shell ]]; then
				installed_in_default_shell=true
			fi
		fi
	else
		echo "Couldn't find file: $init_shell_file"
	fi
done

if [[ $installed_in_default_shell == true ]]; then
	echo -e "\033[1mSuccessfully installed\033[0m"
else
	echo -e "\033[1m[Attention!!] Unsuccessful instalation!\033[0m"
	echo -e "\033[1mPlease add \"$source_command\" to the ~/.bashrc equivalent file.\033[0m"
fi
