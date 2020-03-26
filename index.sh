#!/bin/bash

pwd_stack=()
stack_index=0

function go {
        stack_index=`expr $stack_index + 1`
        pwd_stack[$stack_index]=$(pwd)
        cd $1
}

function back {
        if [[ $stack_index -lt 1 ]]; then
                echo "No more directories back."
                return
        fi
        cd $pwd_stack[$stack_index]
        unset 'pwd_stack[$stack_index]'
        stack_index=`expr $stack_index - 1`
}
