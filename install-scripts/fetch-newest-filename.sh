#! /bin/bash

set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

# # The block below functions interactively
# read -r -p "enter directory (only full paths pls; no ~, \$HOME) >> " searchdir
# readlink -f "$searchdir"
# newfile=`find "$1" -type f -printf '%T@ %f\n' | sort -n | tail -1 | awk -F" " '{split($2, subfield, "."); print subfield[1]}'`


# This block is callable with $1 as the script's argument
newfile=`find "$1" -type f -printf '%T@ %f\n' | sort -n | tail -1 | cut -d ' ' -f 2
echo $newfile
