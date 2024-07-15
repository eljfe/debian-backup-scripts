#!/usr/bin/bash

# SMUGGLE non-sudo users into script
# run as sudo
# whoami
# sudo -i -u bossy bash << EOF
# echo "In"
# whoami
# EOF
# echo "Out"
# whoami

names="bossy elfe"

for n in $names; do 
	echo $n
done
