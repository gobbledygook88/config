#!/bin/bash

echo "Configuring package repositores..."
grep -v "^#" /etc/apt/sources.list | grep universe >/dev/null 2>&1 || sudo add-apt-repository universe

echo "Installing system applications..."
sudo apt update && sudo apt install -y \
    build-essential    \
    cmake              \
    curl               \
    feh                \
    fonts-firacode     \
    fonts-font-awesome \
    git                \
    htop               \
    i3                 \
    i3blocks           \
    libx11-dev         \
    libxft-dev         \
    python-dev         \
    python3-dev        \
    python-pip         \
    tree               \
    vim-gtk3           \
    xautolock          \
    xbacklight

sudo pip install flake8

echo "Moving config files into position..."
mkdir -p $HOME/.config
rsync -avr ./config/ $HOME/.config/

echo "Moving dotfiles files into position..."
rsync -av ./dotfiles/ $HOME/

echo "Moving wallpapers into position..."

echo "Installing vim plugins..."
AUTOLOAD_DIR=$HOME/.vim/autoload
BUNDLE_DIR=$HOME/.vim/bundle
mkdir -p $AUTOLOAD_DIR $BUNDLE_DIR

[ ! -f "$AUTOLOAD_DIR/pathogen.vim" ] && curl -LSso $AUTOLOAD_DIR/pathogen.vim https://tpo.pe/pathogen.vim

[ ! -d "$BUNDLE_DIR/goyo.vim"      ] && git clone https://github.com/junegunn/goyo.vim.git $BUNDLE_DIR/goyo.vim
[ ! -d "$BUNDLE_DIR/nerdcommenter" ] && git clone https://github.com/scrooloose/nerdcommenter.git $BUNDLE_DIR/nerdcommenter
[ ! -d "$BUNDLE_DIR/nerdtree"      ] && git clone https://github.com/scrooloose/nerdtree.git $BUNDLE_DIR/nerdtree
[ ! -d "$BUNDLE_DIR/vim-flake8"    ] && git clone https://github.com/nvie/vim-flake8.git $BUNDLE_DIR/vim-flake8
[ ! -d "$BUNDLE_DIR/vim-fugitive"  ] && git clone https://github.com/tpope/vim-fugitive.git $BUNDLE_DIR/vim-fugitive && \
    vim -u NONE -c "helptags vim-fugitive/doc" -c q

[ ! -d "$BUNDLE_DIR/vim-colors-solarized" ] && git clone https://github.com/altercation/vim-colors-solarized.git $BUNDLE_DIR/vim-colors-solarized

[ ! -d "$BUNDLE_DIR/YouCompleteMe" ] && git clone https://github.com/Valloric/YouCompleteMe.git $BUNDLE_DIR/YouCompleteMe && \
    cd $BUNDLE_DIR/YouCompleteMe && \
    git submodule update --init --recursive && \
    ./install.py --clang-completer && \
    cd -

echo "Installing Google Chrome..."
command -v google-chrome >/dev/null 2>&1 || echo "Installing google chrome now..."

echo "Installing Atom (text editor)..."
command -v atom >/dev/null 2>&1 || echo "Installing atom now..."

echo "Perform the following manual changes..."
echo "* Change Konsole theme to Solarized Dark"
echo "* Change Konsole font to Fira Code"
echo "* Reload i3: Mod1+Shift+r"
