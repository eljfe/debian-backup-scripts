#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo -u <some-user>  ${0}'"

##################################
## build an array of user names ##
##################################
# 1st get the userland usernames from /etc/passwd - separated by spaces
ust=$(cat /etc/passwd | grep home | awk -F':' '{print $1}' | sed 'N;s/\n/ /g')
# 2nd space separated list to array ${ulist}
IFS=' ' read -r -a ulist <<< "$ust"
# fancy itemized listing looper
# https://stackoverflow.com/a/9718667
# $((${#ulist}[*]-1));   <-- what is this!?
# $(( blahblah -1)) is the 'do math' part
# ${blah} is the string reference
# ${#blah[*]} is the numeric length of the array
echo "--> choose a freakin' user from this list (sorry grumpy today), "
for i in $(seq 0 $((${#ulist[*]}-1))); do
	echo $((1+${i})). ${ulist[i]} 
done 
read -r -p "... plz ...." choice
choice=$((${choice}-1))
echo ${ulist[${choice}]}
exit

