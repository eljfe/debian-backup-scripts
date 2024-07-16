#!/usr/bin/bash

git config --global init.defaultBranch trunk
git config --global user.name $USER
git config --global user.email "jeff@passedpawn.com"
git config --global core.editor vim
git config --global core.autocrlf input
git config --global --list
