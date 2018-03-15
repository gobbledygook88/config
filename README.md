Packages:
- git
- curl
- tree
- htop
- rofi
- vim-gtk
  - vim plugins (see below)
- i3
- i3blocks
- feh
- xbacklight
- Google chrome
- Atom

Configs:
- $HOME/.config/i3/config
- $HOME/.config/i3blocks/config
- $HOME/.config/rofi/config

Dotfiles:
- .vimrc
- .bashrc
- .bash_aliases
- .bash_function

Fonts:
- apt install fira-code
- apt install fonts-font-awesome

Wallpapers:
- download into directory
- i3lock only supports png
- use imagemagick's convert tool
- convert /path/tp/image.jpg --resize WxH^ -gravity center -extent WxH /path/to/image.png
- use xrandr | grep '*' to find screen resolution

vim plugins:
- pathogen (https://github.com/tpope/vim-pathogen)
  - mkdir -p ~/.vim/autoload ~/.vim/bundle && \
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
- nerdcommenter (https://github.com/scrooloose/nerdcommenter)
  - git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
- nerdtree (https://github.com/scrooloose/nerdtree)
  - git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
- vim-flake8 (https://github.com/nvie/vim-flake8)
  - sudo pip install flake8
  - git clone https://github.com/nvie/vim-flake8.git ~/.vim/bundle/vim-flake8
- vim-fugitive (https://github.com/tpope/vim-fugitive)
  - git clone https://github.com/tpope/vim-fugitive.git ~/.vim/bundle/vim-fugitive
  - vim -u NONE -c "helptags vim-fugitive/doc" -c q
- YouCompleteMe
  - sudo apt install build-essential cmake python-dev python3-dev
  - git clone https://github.com/Valloric/YouCompleteMe.git ~/.vim/bundle/YouCompleteMe
  - cd ~/.vim/bundle/YouCompleteMe
  - git submodule update --init --recursive
  - ./install.py --clang-completer
- goyo (https://github.com/junegunn/goyo.vim.git)
  - git clone https://github.com/junegunn/goyo.vim.git ~/.vim/bundle/goyo.vim
- fzf.vim (https://github.com/junegunn/fzf.vim.git)
  - git clone https://github.com/junegunn/fzf.vim.git ~/.vim/bundle/fzf.vim

st
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

session scripts
- logout
- suspend
- shutdown
- reboot

network
- wifi

sound

laptop brightness
- xbacklight
- need extra step

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

python
- bpython
- ipython
- pudb
