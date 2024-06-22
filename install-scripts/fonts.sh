#! /bin/bash

set -e 	# exit if anything goes wrong
# set -x 	# debugging

# if [[ $(id -u) -ne 0 ]] ; then 
# 	echo "Please run as root" ; 
# 	exit 1;
# fi

fontdir="$HOME/.temp/fonts"
mkdir -p $fontdir
cd $fontdir


# =================================
# Julia Mono
# =================================
# https://stackoverflow.com/a/61374021 
wget "https://github.com/cormullion/juliamono/releases/download/v0.055/JuliaMono-ttf.tar.gz?raw=true"

# wget filename tidy (get rid of the http junk and the single quotes
# https://superuser.com/a/1019508
for i in `find $1 -type f`
do
	mv $i `echo $i | cut -d? -f1`
done

# =================================
# 
# =================================


# =================================
# update font-manager
# =================================
apt -y install fonts-recommended
apt -y install font-manager



Hi - Is it possible to somehow download the `fonts-recommended` package and subsequently install them in the directory of my choosing?  

## requirements

1. Install the TTFs locally without installing them system wide (per https://wiki.debian.org/Fonts#Manually)
2. accomplish this as a non-sudo-er.  

## so far
As indicated in the subject line, I tried a couple of seemingly reasonable `apt` options:

`apt source fonts-recommended`
`apt download fonts-recommended`

My assumption - since proved wrong - was that I would be downloading an archive of TTF files. I imagined I could then move them into a directory of my choice.  I now realize neither of these commands actually download anything resembling an archive of font files.

## goals
1. as stated above, install the fonts in the `fonts-recommended` package locally
2. as a non-sudoer
3. Furthermore I wish to have this as a reproducable install script 

