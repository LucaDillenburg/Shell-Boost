#!/bin/bash

function __get_file_path_custom_aliases {
	echo "$(__get_data_folder)/custom_aliases.sh"
}
function __overwrite_custom_aliases_file {
	echo "#!/bin/bash" > $(__get_file_path_custom_aliases)
}

if ! [[ -f $(__get_file_path_custom_aliases) ]]; then
	touch $(__get_file_path_custom_aliases)
	__overwrite_custom_aliases_file
fi
source $(__get_file_path_custom_aliases)

function create_custom_cd_aliases {
	if [[ $1 == "--help" ]]; then
		__echo_create_cd_alias
		return 0
	fi

	if ! [[ -z $(grep alias $(__get_file_path_custom_aliases)) ]]; then
		printf "Do you want to overwrite the commands already created by this command? (if you choose NO the aliases will be appended) [y/N] "
		read -r response
		if [[ response == "y" || response == "Y" ]]; then
			__overwrite_custom_aliases_file
			echo "Unless you create other aliases with the names of the old ones, they will still be accessible in this terminal session. The next time you open a terminal window or tab they won't be accessible anymore."
		fi
	fi

	echo "You can press Ctrl+C when you don't want to create more aliases."
	echo ""

	while true
	do
		directory=""
		while true
		do
			printf "Enter directory path (relative or absolute): "
			read -r directory #todo directory auto-completition

			directory=$(__get_absolute_path $directory)
			if ! [[ -d $directory ]]; then
				__echo_error "No such directory: $directory"
			else
				break
			fi
		done

		_alias=""
		while true
		do
			printf "Enter alias (keep it short): "
			read -r _alias

			if [[ -z $(grep '^[_a-zA-Z][_a-zA-Z0-9\-]*$' <<< $_alias) ]]; then
				__echo_error "Invalid alias. Alias name rules:"
				__echo_error "1. It has to start with a letter or underline."
				__echo_error "2. It can only have letters, numbers, underlines and hyphens."
				echo ""
			else
				break
			fi
		done

		alias_command="alias $_alias='$directory'"
		echo "$_alias alias created: $alias_command"
		echo $alias_command >> $(__get_file_path_custom_aliases)

		echo ""
		printf "Do you want to create another custom alias? [Y/n] "
		read -r response
		if [[ $response == "n" || $response == "N" ]]; then
			break
		fi
	done

	echo "Have a nice day :D"
}
