#!/bin/bash

# TODO need st config.h

echo "Installing st dependencies..."
sudo apt install -y \
    libx11-dev   \
    libxft-dev

echo "Installing st..."
cd $HOME/Documents
wget https://dl.suckless.org/st/st-0.7.tar.gz
tar -xvf st-0.7.tar.gz
rm st-0.7.tar.gz
cd st-0.7

wget https://st.suckless.org/patches/scrollback/st-scrollback-0.7.diff  
patch -p1 < st-scrollback-0.7.diff

wget https://st.suckless.org/patches/solarized/st-no_bold_colors-0.7.diff
patch -p1 < st-no_bold_colors-0.7.diff

wget https://st.suckless.org/patches/solarized/st-solarized-dark-0.7.diff
patch -p1 < st-solarized-dark-0.7.diff

sudo make clean install
