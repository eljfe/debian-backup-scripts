#! /bin/bash

set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

function proceed(){
	read -r -p "... Proceed? (Y/n) ... " go
	pat='y$|Y$|^$'
	if [[ ! $go =~ $pat ]]; then
			echo "--> bye"
				exit
	fi
}
