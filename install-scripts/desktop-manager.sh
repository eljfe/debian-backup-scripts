#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo ${USER} ${0}'"
source proceed-conditional.sh
$(proceed)

nala install nala install slick-greeter

cat << EOF 
You need to update a couple of files:

1. etc/lightdm/lightdm.conf
2. /usr/share/lightdm/lightdm.conf.d/50-slick-greeter.conf
3. /etc/lightdm/slick-greeter.conf

-------------------------------------------------------

1. add/uncomment these lines in etc/lightdm/lightdm.conf

greeter-session=slick-greeter
greeter-hide-users=false

----------------------

2. add this to /usr/share/lightdm/lightdm.conf.d/50-slick-greeter.conf

[Seat:*]
greeter-session=slick-greeter

----------------------

3. and if you want background images and stuff, add this to /etc/lightdm/slick-greeter.conf

[Greeter]
draw-user-backgrounds=false
background=/usr/share/backgrounds/general/IMG_0529.jpeg
draw-grid=false
cursor-theme-size=29


EOF

