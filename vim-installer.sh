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
echo ":colorscheme slate" >> .vimrc
sleep 1

#Install Snipmate
echo "Installing Snipmate..."
cd ~/.vim/bundle
git clone https://github.com/msanders/snipmate.vim.git
cd ~
sleep 1

#Install minibufexpl
echo "Installing Minibufexpl..."
cd ~/.vim/bundle
git clone https://github.com/sontek/minibufexpl.vim.git
cd ~
sleep 1

#Install sessionman.vim
echo "Installing sessionman.vim..."
cd ~/.vim/bundle
git clone https://github.com/vim-scripts/sessionman.vim.git
cd ~
sleep 1

#Install TaskList.vim
echo "Installing TaskList.vim..."
cd ~/.vim/bundle
git clone https://github.com/vim-scripts/TaskList.vim.git
cd ~
sleep 1

#Install vim-jsbeautify
echo "Installing jsbeautify..."
cd ~/.vim/bundle
git clone https://github.com/maksimr/vim-jsbeautify.git
cd ~/.vim/bundle/vim-jsbeautify
git submodule update --init --recursive
cd ~
sleep 1

#Install vim-markdown.vim
echo "Installing vim-markdown.vim..."
cd ~/.vim/bundle
git clone https://github.com/plasticboy/vim-markdown.git
cd ~
sleep 1

#Install Mustache.vim
echo "Installing mustache.vim..."
cd ~/.vim/bundle
git clone https://github.com/juvenn/mustache.vim.git
cd ~
sleep 1


#Adding extra configs
echo "set smartindent" >> .vimrc
echo "set tabstop=4" >> .vimrc
echo "set shiftwidth=4" >> .vimrc
echo "set expandtab" >> .vimrc
echo "nmap <Space>d :NERDTreeToggle<CR>" >> .vimrc
echo "nmap <Leader>d :NERDTreeToggle<CR>" >> .vimrc
echo "map T :TaskList<CR>" >> .vimrc
echo "map P :TlistToggle<CR> "Ctags" >> .vimrc
echo "let NERDTreeIgnore = ['\.pyc$']" >> .vimrc

#More to be added

echo "Finished"

exit 0
