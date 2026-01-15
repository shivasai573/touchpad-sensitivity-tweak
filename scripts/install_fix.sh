#!/bin/bash

# 1. Detect the Package Manager
if [ -x "$(command -v dnf)" ]; then
    PKG_MANAGER="dnf"
    DEPS="meson ninja-build gcc libinput-devel git"
elif [ -x "$(command -v apt-get)" ]; then
    PKG_MANAGER="apt"
    DEPS="meson ninja-build gcc libinput-dev git"
elif [ -x "$(command -v pacman)" ]; then
    PKG_MANAGER="pacman"
    DEPS="meson ninja gcc libinput git"
else
    echo "Unsupported package manager. Please install dependencies manually."
    exit 1
fi

echo "Detected $PKG_MANAGER. Installing dependencies..."

# 2. Install Dependencies
if [ "$PKG_MANAGER" == "dnf" ]; then
    sudo dnf install -y $DEPS
elif [ "$PKG_MANAGER" == "apt" ]; then
    sudo apt-get update && sudo apt-get install -y $DEPS
elif [ "$PKG_MANAGER" == "pacman" ]; then
    sudo pacman -S --needed --noconfirm $DEPS
fi

# 3. Build libinput-config (Common for all)
echo "Building libinput-config..."
mkdir -p ~/build-tweak && cd ~/build-tweak
git clone https://gitlab.com/warningnoname/libinput-config.git
cd libinput-config
meson build
ninja -C build
sudo ninja -C build install

# 4. Create the config file
echo "Applying sensitivity tweak..."
sudo bash -c 'cat <<EOF > /etc/libinput.conf
scroll-factor=0.3
EOF'

echo "Done! Please restart your session to apply changes."