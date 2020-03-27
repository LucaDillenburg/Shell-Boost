#!/bin/bash

function __print_msg_no_directories {
	echo "No more directories "$1"."
}

function __goto_virtually_curr_dir {
	cd $DIRECTORIES_HISTORY[$INDEX_CURR_DIR]
}