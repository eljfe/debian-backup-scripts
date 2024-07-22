#! /bin/bash
set -e	# exit any non-successful executions
# set -x	# debugging: echo commands as you go

echo "--> This script needs to be called like so:"
echo "         'sudo -u ${USER} ${0}'"
# read -r -p "... Proceed? (Y/n) ... " go
# pat='y$|Y$|^$'
# if [[ ! $go =~ $pat ]]; then
	# echo "--> bye"
	# exit
# fi
source proceed-conditional.sh

sshdir=${HOME}"/.ssh/"
newkey="github_ed25519"
scriptdir=$(pwd)

# interactive ssh key generation
echo "--> making your new key"
ssh-keygen -t ed25519 -C "jeff@passedpawn.com" -f "${sshdir}${newkey}" -N '' <<< $'\ny' >/dev/null 2>&1
echo "--> key made"
echo "--> registering your key"
eval "$(ssh-agent -s)"
ssh-add $newkey
cat << EOF >> ${sshdir}config 
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
