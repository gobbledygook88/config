#!/bin/bash

# Break script on error
set -e

echo "Configuring package repositores..."
grep -v "^#" /etc/apt/sources.list | grep universe >/dev/null 2>&1 || sudo add-apt-repository universe

echo "Installing system applications..."
sudo apt update && sudo apt install -y \
    build-essential    \
    cmake              \
    cmus               \
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
    ranger             \
    tree               \
    vim-gtk3           \
    xautolock          \
    xbacklight

sudo pip install flake8

echo "Moving dotfiles files into position..."
rsync -av ./dotfiles/ "$HOME/"

echo "Moving config files into position..."
mkdir -p "$HOME/.config"
rsync -avr ./config/ "$HOME/.config/"

mkdir -p "$HOME/.local"
rsync -avr ./local/ "$HOME/.local/"

echo "Resizing and configuring wallpapers..."
DIMENSIONS=$(xrandr | grep '[*]' | awk '{ print $1 }')
DESKTOP_SOURCE="wallpapers/mikael_gustafsson_small_memory.png"
DESKTOP_TARGET="wallpapers/desktop.png"
LOCKSCREEN_SOURCE="wallpapers/ill_leave_tomorrows_problems_to_tomorrows_me.jpg"
LOCKSCREEN_TARGET="wallpapers/lockscreen.png"
echo "Resizing wallpaper images to $DIMENSIONS"
convert "$DESKTOP_SOURCE" -resize "$DIMENSIONS^" -gravity center -extent "$DIMENSIONS" "$DESKTOP_TARGET"
convert "$LOCKSCREEN_SOURCE" -resize "$DIMENSIONS^" -gravity center -extent "$DIMENSIONS" "$LOCKSCREEN_TARGET"

echo "Installing vim plugins..."
AUTOLOAD_DIR=$HOME/.vim/autoload
BUNDLE_DIR=$HOME/.vim/bundle
mkdir -p "$AUTOLOAD_DIR" "$BUNDLE_DIR"

[ ! -f "$AUTOLOAD_DIR/pathogen.vim" ] && curl -LSso "$AUTOLOAD_DIR/pathogen.vim" https://tpo.pe/pathogen.vim

[ ! -d "$BUNDLE_DIR/goyo.vim"      ] && git clone https://github.com/junegunn/goyo.vim.git "$BUNDLE_DIR/goyo.vim"
[ ! -d "$BUNDLE_DIR/nerdcommenter" ] && git clone https://github.com/scrooloose/nerdcommenter.git "$BUNDLE_DIR/nerdcommenter"
[ ! -d "$BUNDLE_DIR/nerdtree"      ] && git clone https://github.com/scrooloose/nerdtree.git "$BUNDLE_DIR/nerdtree"
[ ! -d "$BUNDLE_DIR/vim-flake8"    ] && git clone https://github.com/nvie/vim-flake8.git "$BUNDLE_DIR/vim-flake8"
[ ! -d "$BUNDLE_DIR/vim-fugitive"  ] && git clone https://github.com/tpope/vim-fugitive.git "$BUNDLE_DIR/vim-fugitive" && \
    vim -u NONE -c "helptags vim-fugitive/doc" -c q

[ ! -d "$BUNDLE_DIR/vim-colors-solarized" ] && git clone https://github.com/altercation/vim-colors-solarized.git "$BUNDLE_DIR/vim-colors-solarized"

[ ! -d "$BUNDLE_DIR/YouCompleteMe" ] && git clone https://github.com/Valloric/YouCompleteMe.git "$BUNDLE_DIR/YouCompleteMe" && \
    cd "$BUNDLE_DIR/YouCompleteMe" && \
    git submodule update --init --recursive && \
    ./install.py --clang-completer && \
    cd - || exit

echo "Installing fzf..."
command -v fzf >/dev/null 2>&1 || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "Installing NodeJS and NPM (via NVM)"
command -v nvm >/dev/null 2>&1 || curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash

echo "Installing Google Chrome..."
command -v google-chrome >/dev/null 2>&1 || echo "Installing google chrome now..."

echo "Installing Atom (text editor)..."
command -v atom >/dev/null 2>&1 || echo "Installing atom now..."

echo "Installing Atom packages..."
ATOM_INSTALLED_PACKAGES=$(apm list)
echo "$ATOM_INSTALLED_PACKAGES" | grep "atom-ide-ui" || apm install atom-ide-ui
echo "$ATOM_INSTALLED_PACKAGES" | grep "ide-typescript" || apm install ide-typescript
echo "$ATOM_INSTALLED_PACKAGES" | grep "react" || apm install react
echo "$ATOM_INSTALLED_PACKAGES" | grep "vim-mode-plus" || apm install vim-mode-plus

echo "Perform the following manual changes..."
echo "* Reload i3: Mod1+Shift+r"
