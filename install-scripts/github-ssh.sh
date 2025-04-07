#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo -u  ${0}'"
source proceed-conditional.sh
$(proceed)


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
read -r -p "... plz ...   " choice
choice=$((${choice}-1))
usrname=${ulist[${choice}]}

sshdir=/home/${usrname}"/.ssh/"
newkey="github_ed25519"
scriptdir=$(pwd)

# sudo -u ${usrname} 

# .ssh directory exists test
if [ ! -f ${sshdir} ]; then
	echo "--> the ssh config folder is missing from you home directory,"
	echo "         ${sshdir}"
	echo "    ... and no proceeding without it.  Shall I make it now?"
	$(proceed)
	sudo -u ${usrname} mkdir -p ${sshdir}
	echo "    ... done"
fi

# interactive ssh key generation
echo "--> making your new key"
# echo "TEST ${sshdir}${newkey}"
sudo -u ${usrname} ssh-keygen -t ed25519 -C "jeff@passedpawn.com" -f "${sshdir}${newkey}" -N '' <<< $'\ny' >/dev/null 2>&1
echo "--> key made"
echo "--> registering your key"
sudo -u ${usrname} eval "$(sudo -u ${usrname} ssh-agent -s)"
sudo -u ${usrname} ssh-add $newkey
sudo -u ${usrname} cat << EOF >> ${sshdir}config 
Host github.com
	User git
	IdentityFile ${sshdir}${newkey}
	IdentitiesOnly yes
EOF
cat << EOF
--> key registered

--> Now you will need to register ${newkey}.pub with your github account
    You can do so here: https://github.com/settings/keys ... which is 
    accessible after logging in to github.com at:
    			(top right) Settings > (mid left) SSH & GPG keys


--> Note, if the key gives you trouble, register it again from the 
    commandline with 'eval \"$(ssh-agent -s)\"' then 'ssh-add ${newkey}'
    ... 
--> Also, 'ssh -vT git@github.com' is a git recommended command that
    is handy.  Seach the output for evidence of your new key (${newkey}).
    If it isn't present (and I'll bet it isn't) you will need to reregister.
    it as above.  I don't have confidence this script registers keys
    properly... 
EOF

# don't think I need these lines
# echo "--> checking whether "
# cd /etc/ssh/
# grep Password ssh_config
# sudo vim ssh_config
# sudo systemctl restart ssh.service
