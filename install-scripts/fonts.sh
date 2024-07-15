#! /usr/bin/bash

set -e 	# exit if anything goes wrong
# set -x 	# debugging

echo "--> This script needs to be called like so:"
echo "         'sudo ${0}'"
echo 
source ./proceed-conditional.sh

homeuser="bossy"
tempfontdir="/home/${homeuser}/.temp/fonts"
sysfontdir="/usr/share/fonts"
ttfontdir=$sysfontdir"/truetype"

cat << EOF

--> This script is hardcoded to install JuliaMono into 
	the system fonts directory (${sysfontdir}) 
--> This script is hardcoded to install JuliaMono into
	the profile of ${homeuser}.  If you want this changed
	you need to do so by ✋.


EOF
source ./proceed-conditional.sh

sudo -i -u $homeuser bash << EOF
mkdir -p $tempfontdir
EOF

# =================================
# Julia Mono
# =================================
juliazip=$tempfontdir"/JuliaMono-ttf.zip"
sudo -i -u $homeuser bash << EOF
wget "https://github.com/cormullion/juliamono/releases/download/v0.056/JuliaMono-ttf.zip" \
	-P $tempfontdir
EOF
unzip $juliazip -d $ttfontdir
rm $ttfontdir/LICENSE

# =================================
# update font-manager
# =================================

apt -y install font-manager

exit


# wget filename tidy (get rid of the http junk and the single quotes
# https://superuser.com/a/1019508
# for i in `find $1 -type f`
# do
# 	mv $i `echo $i | cut -d? -f1`
# done
