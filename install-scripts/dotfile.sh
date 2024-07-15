#! /bin/bash

set -e	# exit any non-successful executions
# set -x	# echo commands as you go

# variables
dotgrp="dotfile"
# targetdir="/srv/testdir"
dotgrpusers="bossy eljfe"
dotfileowner="bossy:$dotgrp"
gitrepo=$dotgrp
targetdir="/srv/$gitrepo/.config"
zshdir="${targetdir}/zsh"
vimdir="${targetdir}/vim"

# =================================
# sudo script preamble
# =================================

echo "--> This script needs to be called like so:"
echo "         'sudo ${0}'"
echo 
echo "--> Moreover the following users will be in the dotfile group:"
echo "         $dotgrpusers      # NOTE they are hardcoded in the script."
echo 
source ./proceed-conditional.sh

# =================================
# group setup
# =================================

groupadd $dotgrp
for u in $dotgrpusers
do
	usermod --append --groups $dotgrp $u 
done
echo "--> $(getent group | grep $dotgrp)"

# =================================
# git check
# =================================

echo "--> Review the git settings.  You may need to run 'git-setup.sh'"
echo "    Furthermore you may need to setup your git SSH key (github-ssh.sh)."
echo "        $(git config --list)"
echo 
source ./proceed-conditional.sh

# =================================
# shared directory setup
# =================================

mkdir -p $targetdir
chown $dotfileowner $targetdir
chmod 770 $targetdir

# =================================
# eljfe github D/L
# =================================

sudo -i -u bossy bash << EOF
git clone git@github.com:eljfe/$gitrepo.git $targetdir
EOF
# tree -L 3 $targetdir

# =================================
# zsh environment variable
# =================================

echo "export ZDOTDIR=\"${zshdir}\"" | tee -a "/etc/zsh/zshenv"

# =================================
# zsh plugin(s)
# =================================

# install vi-mode:
sudo -i -u bossy bash << EOF
git clone "https://github.com/jeffreytse/zsh-vi-mode.git" $zshdir"/plugins/zsh-vi-mode"
EOF

# =================================
# vim colour theme setup
# =================================

sudo -i -u bossy bash << EOF
mkdir -p $vimdir"/colors"
curl -L "https://github.com/mctwynne/sitruuna.vim/raw/master/colors/sitruuna.vim" \
	-o $vimdir"/colors/sitruuna.vim"
EOF

# =================================
# vim plugin setup
# =================================

vimpackstart=$vimdir"/pack/packages/start"
sudo -i -u bossy bash << EOF
mkdir -p $vimpackstart
git clone https://github.com/itchyny/lightline.vim \ 
	$vimpackstart"/lightline"

git clone "https://github.com/tpope/vim-commentary.git" \
	$vimpackstart"/commentary"

git clone "https://github.com/tpope/vim-surround.git" \
	$vimpackstart"/vim-surround" 

# git clone "https://github.com/davidhalter/jedi-vim.git" \
# 	"/vim/pack/packages/start/jedi-vim" 

git clone "https://github.com/dense-analysis/ale.git" \
	$vimpackstart"/ale" 

git clone "https://github.com/ervandew/supertab.git" \
	$vimpackstart"/supertab" 

git clone "https://github.com/nvie/vim-flake8.git" \
	$vimpackstart"/vim-flake8" 

git clone "https://github.com/puremourning/vimspector.git" \
	$vimpackstart"/vimspector" 
EOF

# rm -R $targetdir 
# groupdel $dotgrp
exit


# =================================
# kitty
# =================================

cd $DOTFILES/kitty
ll kitty-themes
ll kitty-themes/themes
ln -s theme.conf $KITTY_CONFIG_DIRECTORY/kitty-themes/themes
ln -s $KITTY_CONFIG_DIRECTORY/kitty-themes/themes theme.conf 

echo $DOTFILES
apt search JuliaMono
apt search Julia

find /var -name kitty 2>/dev/null
kitty +runpy 'from kitty.cli import *; print(create_default_opts().font_family)'
find /usr -name kitty 2>/dev/null
cd /usr/share/doc/kitty
v README.Debian


# =================================
# update permissions
# =================================
find $dfdir -type d exec chmod -R 775 {} \;
find $dfdir -type f exec chmod -R 664 {} \;
chown -R bossy:dotfile .config

unset dfdir

