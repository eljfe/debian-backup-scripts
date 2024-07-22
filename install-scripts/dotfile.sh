#
#sudo -i -u $owner bash << EOF
#git clone https://github.com/itchyny/lightline.vim \
#	$vimpackstart"/lightline"
#
#git clone https://github.com/tpope/vim-commentary.git \
#	$vimpackstart"/commentary"
## vim -v -u NONE -tes -c 'helptags "${vimpackstart}/commentary/doc | q'
#
#git clone https://github.com/tpope/vim-surround.git \
#	$vimpackstart"/vim-surround" 
## vim -u NONE -tes -c 'helptags \"${vimpackstart}/vim-surround/doc\" -c q 
#
## git clone "https://github.com/davidhalter/jedi-vim.git" \
## 	"/vim/pack/packages/start/jedi-vim" 
#
## git clone "https://github.com/dense-analysis/ale.git" \
## 	$vimpackstart"/ale" 
#
## git clone --depth=1 https://github.com/ervandew/supertab.git \
## 	$vimpackstart"/supertab" 
#
## git clone "https://github.com/nvie/vim-flake8.git" \
## 	$vimpackstart"/vim-flake8" 
#
## git clone "https://github.com/puremourning/vimspector.git" \
## 	$vimpackstart"/vimspector" 
#
#EOF
#vim -u NONE -c 'helptags ALL' -c q
#
#
## rm -R $targetdir 
## groupdel $dotgrp
#exit
#
#
## =================================
## update permissions
## =================================
#find $dfdir -type d -exec chmod -R g+x {} \;
#find $dfdir -type f -exec chmod -R 0-wx {} \;
#
#unset dfdir



#! /bin/bash

set -e	# exit any non-successful executions
# set -x	# echo commands as you go

# variables
dotgrp="dotfile"
# targetdir="/srv/testdir"
owner=bossy
dotgrpusers="$owner eljfe"
dotfileowner="$owner:$dotgrp"
gitrepo=$dotgrp
targetdir="/srv/$gitrepo/.config"
zshdir="${targetdir}/zsh"
vimdir="${targetdir}/vim"

# =================================
# sudo script preamble
# =================================

cat << EOF
--> This script needs to be called like so:
         'sudo ${0}'

--> Moreover the following users will be in the dotfile group:
         $dotgrpusers      # NOTE they are hardcoded in the script.
   ... with the owner being $owner
EOF
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

sudo -i -u $owner bash << EOF
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
sudo -i -u $owner bash << EOF
git clone "https://github.com/jeffreytse/zsh-vi-mode.git" $zshdir"/plugins/zsh-vi-mode"
EOF

# =================================
# vim colour theme setup
# =================================

vimcolours=$vimdir"/colors"
mkdir -p $vimcolours
chown $dotfileowner $vimcolours
chmod -R 770 $vimcolours
sudo -i -u $owner bash << EOF
sudo -i -u $owner bash << EOF
curl -L "https://raw.githubusercontent.com/eemed/sitruuna.vim/master/colors/sitruuna.vim" \
	-o $vimcolours"/sitruuna.vim"
EOF

# =================================
# vim plugin setup
# =================================

vimpackstart=$vimdir"/pack/packages/start"
mkdir -p $vimpackstart
chown $dotfileowner $vimpackstart
chown -R $dotfileowner $vimdir
find $vimdir -type d -exec chmod -R g+x {} \;

sudo -i -u $owner bash << EOF

git clone https://github.com/itchyny/lightline.vim \
	$vimpackstart"/lightline"

git clone https://github.com/tpope/vim-commentary.git \
	$vimpackstart"/commentary"
 this doesn't work after too much effort... 😭
# vim -v -u NONE -tes -c 'helptags "${vimpackstart}/commentary/doc | q'

git clone https://github.com/tpope/vim-surround.git \
	$vimpackstart"/vim-surround" 
# vim -u NONE -tes -c 'helptags \"${vimpackstart}/vim-surround/doc\" -c q 

## git clone "https://github.com/davidhalter/jedi-vim.git" \
## 	"/vim/pack/packages/start/jedi-vim" 
#
## git clone "https://github.com/dense-analysis/ale.git" \
## 	$vimpackstart"/ale" 
#
 git clone --depth=1 https://github.com/ervandew/supertab.git \
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
find $dfdir -type d exec chmod -R g+x {} \;
find $dfdir -type f exec chmod -R 0-wx {} \;
chown -R $dotfileowner .config

unset dfdir

