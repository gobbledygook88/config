#!/bin/bash

echo "Configuring package repositores..."
grep -v "^#" /etc/apt/sources.list | grep universe >/dev/null 2>&1 || sudo add-apt-repository universe

echo "Installing system applications..."
sudo apt update && sudo apt install -y \
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
    tree               \
    vim-gtk3           \
    xautolock          \
    xbacklight

echo "Moving config files into position..."

echo "Moving dotfiles files into position..."

echo "Moving wallpapers into position..."

echo "Installing vim plugins..."

echo "Installing Google Chrome..."
command -v google-chrome >/dev/null 2>&1 || echo "Installing google chrome now..."

echo "Installing Atom (text editor)..."
command -v atom >/dev/null 2>&1 || echo "Installing atom now..."

echo "Perform the following manual changes..."
