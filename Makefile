echo "Installing system applications..."
sudo apt update && sudo apt install -y \
    curl               \
    feh                \
    fonts-font-awesome \
    git                \
    htop               \
    i3                 \
    i3blocks           \
    libx11-dev         \
    libxft-dev         \
    rofi               \
    tree               \
    vim-gtk            \
    xautolock

echo "Moving config files into position..."

echo "Moving dotfiles files into position..."

echo "Moving wallpapers into position..."
