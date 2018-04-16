Config
======

Here is a collection of configuration files which I use to set up a new Kubuntu install.

All are welcome to fork and adapt to your own distro/preferences.

## Installation

Clone the repository, ideally into your `$HOME` directory and run the install script.

Be sure to check the contents of the script before running. `sudo` is required for some commands.

```bash
git clone https://github.com/gobbledygook88/config
./config/install.sh
```

## Wallpapers
- download into directory
- i3lock only supports png
- use imagemagick's convert tool
- `convert /path/tp/image.jpg --resize WxH^ -gravity center -extent WxH /path/to/image.png`
- use `xrandr | grep '*'` to find screen resolution

## Vim plugins

The following Vim plugins are installed

- pathogen (https://github.com/tpope/vim-pathogen)
- nerdcommenter (https://github.com/scrooloose/nerdcommenter)
- nerdtree (https://github.com/scrooloose/nerdtree)
- vim-flake8 (https://github.com/nvie/vim-flake8)
- vim-fugitive (https://github.com/tpope/vim-fugitive)
- YouCompleteMe
- goyo (https://github.com/junegunn/goyo.vim.git)

## st

Originally, I tinkered with st by suckless. Below are the commands to install and apply patches which I'm
keeping here for safe keeping. It is not installed via the install script.

- deps
  - libx11-dev (xatom.h)
  - libxft-dev (xft.h)
- download
  - wget https://dl.suckless.org/st/st-0.7.tar.gz
  - tar -xvf st-0.7.tar.gz
  - cd st-0.7
- apply patches
  - wget https://st.suckless.org/patches/scrollback/st-scrollback-0.7.diff  
  - patch -p1 < st-scrollback-0.7.diff
  - wget https://st.suckless.org/patches/solarized/st-no_bold_colors-0.7.diff
  - patch -p1 < st-no_bold_colors-0.7.diff
  - wget https://st.suckless.org/patches/solarized/st-solarized-dark-0.7.diff
  - patch -p1 < st-solarized-dark-0.7.diff
- install
  - sudo make clean install

network
- TODO autodetect wifi device name (iwconfig)

lockscreen:
- i3lock (installed via i3)
- i3lock -e -n -u -i /path/to/image.png
  - `-e`: Ignore empty passwords
  - `-n`: Do not fork
  - `-u`: Do not show password indicator
  - `-i`: Path to image to use as wallpaper
- TODO lock from suspend

xprop: then click on window to get WM_NAME(STRING) [instance], [class]

DESKTOP_SESSION=kde (put in .bashrc)

## Other development tools

python
- bpython
- ipython
- pudb
