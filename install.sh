#!/bin/bash

# Break script on error
set -e

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
    imagemagick        \
    libx11-dev         \
    libxft-dev         \
    net-tools          \
    playerctl          \
    vim-gtk3           \
    xautolock          \
    xbacklight         \
    xclip

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

echo "Installing vim-plug ..."
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

echo "Installing fzf..."
command -v fzf >/dev/null 2>&1 || git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

echo "Installing NodeJS and NPM (via NVM)"
command -v nvm >/dev/null 2>&1 || curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash

echo "Perform the following manual changes..."
echo "* Reload i3: Mod1+Shift+r"
echo "* Install neovim: https://github.com/neovim/neovim/releases"
echo "* Install pyenv"
