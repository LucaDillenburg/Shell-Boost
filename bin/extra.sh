alias c='clear;'
alias ..='cd ..;'

function mkcd {
	if [[ $1 == "--help" || $1 == "-h" ]]; then
		__echo_mkcd_help
	elif [[ -z $1 ]]; then
		__echo_error "mkcd: missing argument"
	else
		mkdir $1 2> /tmp/Error
		_error=$(</tmp/Error) # The shell recognizes this and doesn't have to run 'cat' /tmp/ERROR to get the data.
		if ! [[ -z $_error ]]; then
			__echo_error "mkcd: ${_error:5}"
		else
			cd $1
		fi
	fi
} 

alias test_output='echo "it worked my dear lord"'