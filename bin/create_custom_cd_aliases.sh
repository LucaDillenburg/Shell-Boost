#!/bin/bash

function create_custom_cd_aliases {
	#echo "Do you want to append the existing custom"
	echo $(__bold "You can press Ctrl+C (or Command+. for macOS) at any moment to stop creating aliases. The aliases already created won't be lost.")

	initial_pwd=$(pwd)

	while true
	do
		directory=""
		while true
		do
			printf "Enter directory path (relative or absolute): "
			read -r directory

			#directory=$(__get_absolute_path $directory)
			if ! [[ -d $directory ]]; then
				__echo_error "No such directory: $directory"
			else
				break
			fi
		done

		_alias=""
		while true
		do
			printf "Enter alias (keep it short):"
			read -r _alias

			if [[ -z $_alias ]]; then
				__echo_error "The alias cannot be empty."
			else
				break
			fi
		done

		echo "$_alias alias created: alias $_alias='$directory'"
		#todo

		printf "Do you want to create another custom alias?[Y/n]"
		read -r response
		if [[ $response == "n" || $response == "N" ]]; then
			break
		fi
	done

	echo "Have a nice day :D "
	#source $SH_NAV_HOME/bin/custom_aliases.sh
}
