#! /bin/bash

set -e	# exit any non-successful executions
set -x	# echo commands as you go


echo "--> you must run `$0` as sudo"
echo "--> try `sudo -u bossy -H $0`\n\n"

# =================================
# shared directory setup
# =================================

# directory setup
mkdir -p "/srv/dotfile"
cd "/srv/dotfile"

# =================================
# eljfe github D/L
# =================================

# download from my github
git clone "https://github.com/eljfe/dotfile.git"
# the directory isn't called `.config` in the github repoj
dfdir="/srv/dotfile/.config"
mv "/srv/dotfile/dotfile" "$dfdir"

# =================================
# zsh
# =================================
# create environment variable
echo 'export ZDOTDIR="${dfdir}/.config/zsh"' >> "/etc/zsh/zshenv"

# install vi-mode:
cd "$dfdir/zsh/plugins"
git clone "https://github.com/jeffreytse/zsh-vi-mode.git"


# =================================
# vim
# =================================
cd "$dfdir/.config/vim"

# colour theme
mkdir "colors"
cd "colors"
curl -L "https://github.com/mctwynne/sitruuna.vim/raw/master/colors/sitruuna.vim" \
	-o "sitruuna.vim"

# packages
mkdir -p "$dfdir/pack/packages"
cd "$dfdir/pack/packages"
git clone https://github.com/itchyny/lightline.vim \ 
	"/vim/pack/packages/start/lightline"

git clone "https://github.com/tpope/vim-commentary.git" \
	"/vim/pack/packages/start/commentary"

git clone "https://github.com/tpope/vim-surround.git" \
	"/vim/pack/packages/start/vim-surround" 

# git clone "https://github.com/davidhalter/jedi-vim.git" \
# 	"/vim/pack/packages/start/jedi-vim" 

git clone "https://github.com/dense-analysis/ale.git" \
	"/vim/pack/packages/start/ale" 

git clone "https://github.com/ervandew/supertab.git" \
	"/vim/pack/packages/start/supertab" 

git clone "https://github.com/nvie/vim-flake8.git" \
	"/vim/pack/packages/start/vim-flake8" 

git clone "https://github.com/puremourning/vimspector.git" \
	"/vim/pack/packages/start/vimspector" 


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

