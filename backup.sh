!# /bin/bash
# thx to RedGreen925
# debian forum: https://forums.debian.net/viewtopic.php?p=801669#p801669

# discontinue if any command goes wrong
set -e

cat << EOF

-->  this file is not production ready 😢
     best to edit it 'by ✋'
     Esp. vis-a-vis the destination directory
	 for the 'rsync' command

EOF
exit


# backup to `/tmp/root`
echo "--> running `rsync`"
mkdir -p /tmp/root
rsync -ahPHAXx --delete \
	--exclude={"/boot/efi","/dev/*","/proc/*","/sys/*",\
	"/tmp/*","/run/*","/mnt/*","/media/*","/swapfile",\
	"/lost+found","/home"} / ??

