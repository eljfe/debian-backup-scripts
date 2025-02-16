#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo ${USER} ${0}'"
source proceed-conditional.sh

echo "--> updating... upgrading"
apt update
apt upgrade

echo "--> installing nala"
apt install nala
echo "--> installing git xclip build-essential tree"
nala install git xclip build-essential tree

echo "--> installing papirus-icon-theme"
nala install papirus-icon-theme 

echo "--> installing neofetch tmux bluetooth"
nala install neofetch tmux bluetooth

echo "--> installing nmap"
nala install nmap

echo "--> installing redshift"
nala install redshift redshift-gtk

echo "--> copying settings into ~/.config/redshift.config"
cat << EOF > ~/.config/redshift.conf                                                          
[redshift]
; Set the day and night screen temperatures
temp-day=3350
temp-night=3350
fade=1
location-provider=manual

[manual]
lat=48.1
lon=11.6

[randr]
screen=0 
EOF
