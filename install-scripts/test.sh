#! /bin/bash

set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

# if [[ $(id -u) -ne 0 ]] ; then 
# 	echo "Please run as root" ; 
# 	exit 1;
# fi


echo "HOME is $HOME"

echo "y/n?"
read qua
echo "so $qua then"
