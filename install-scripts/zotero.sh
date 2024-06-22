#! /bin/bash

ztdir="$HOME/.temp/zotero"
echo "--> $ztdir"
mkdir -p "$ztdir"
cd "$ztdir"
pwd 

# =================================
# download
# =================================
# need the outfile else you get a weird and unusable filename
ztfile="Zotero_linux-x86_64"
curl -L 'https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64' -o $ztfile

# =================================
# unpack
# =================================
tar -xjf "$ztfile"

# =================================
# cp to .local bin
# =================================
ztbin="$HOME/.local/bin"
mkdir -p $ztbin
cp -R "$ztdir/$ztfile" $ztbin
cd "$ztbin/$ztfile/"
pwd

# =================================
# cp to .local bin
# =================================
./set_launcher_icon
# won't link without the full path provided by $(pwd)
ln -s "$(pwd)/zotero.desktop" "$HOME/.local/share/applications"

unset ztdir
unset ztfile
unset ztbin

echo "--> done"
