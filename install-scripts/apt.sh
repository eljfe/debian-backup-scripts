#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo ${USER} ${0}'"
source proceed-conditional.sh

apt update
apt upgrade
apt install nala
nala install git xclip build-essential tree
nala install papirus-icon-theme redshift
nala install neofetch tmux bluetooth
nala install nmap

