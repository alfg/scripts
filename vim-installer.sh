#!/bin/bash

#################
# Vim Installer #
#################
# Installs Vim and some useful plugins from git repos
# for Ubuntu/Debian distros. Modify as necessary.

#Install Vim on Ubuntu's apt-get package-manager
echo "Installing Vim and ctags..."
sudo apt-get install vim exuberant-ctags
echo "Vim and ctags Installed. Installing plugins..."
sleep 1

#Install Pathogen
echo "Installing Pathogen..."
mkdir -p ~/.vim/autoload ~/.vim/bundle;
wget -O ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
sleep 1

#Append config lines to .vimrc
cd ~
echo "call pathogen#infect()
syntax on
filetype plugin indent on" >> .vimrc
sleep 1

#Install NerdTree
echo "installing NerdTree..."
cd ~/.vim/bundle
git clone https://github.com/scrooloose/nerdtree.git
sleep 1

#Install Fugitive
echo "Installing Fugitive..."
cd ~/.vim/bundle
git clone git://github.com/tpope/vim-fugitive.git
sleep 1

#Install TagList
echo "Installing TagList..."
cd ~/.vim/bundle
git clone https://github.com/vim-scripts/taglist.vim.git
sleep 1
#More to be added

#Install Aldmeris theme (oblivion)
echo "Installing Aldmeris theme..."
cd ~/.vim/bundle
git clone git://github.com/veloce/vim-aldmeris.git
cd ~
echo ":colorscheme aldmeris" >> .vimrc
sleep 1

#More to be added

echo "Finished"

exit 0