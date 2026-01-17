#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting the touchpad scroll speed fix..."

# 1. Clean up any previous failed attempts
if [ -d "libinput-config" ]; then
    echo "Removing old dependency folder..."
    rm -rf libinput-config
fi

# 2. Clone the working fork from the stable GitHub mirror
echo "Cloning dependency from GitHub mirror..."
if git clone https://github.com/lz42/libinput-config.git; then
    cd libinput-config
else
    echo "ERROR: Failed to clone the repository. Check your internet connection."
    exit 1
fi

# 3. Build the project using Meson and Ninja
echo "Building the project..."
meson setup build || { echo "Meson setup failed. Do you have meson installed?"; exit 1; }

echo "Compiling..."
ninja -C build || { echo "Ninja build failed. Do you have ninja-build installed?"; exit 1; }

# 4. Install (requires sudo)
echo "Installing to system..."
sudo ninja -C build install || { echo "Installation failed at the system level."; exit 1; }

# 5. Create the configuration file with the correct scroll speed
echo "Creating/Updating configuration at /etc/libinput.conf..."
sudo bash -c 'cat <<EOF > /etc/libinput.conf
# libinput-config configuration
# override-compositor=enabled ensures these settings take priority over GNOME
override-compositor=enabled

# scroll-factor: 0.3 for the slower speed we used before
scroll-factor=0.3

# Additional settings
tap=enabled
natural-scroll=enabled
EOF'

echo "------------------------------------------------"
echo "Done! Please restart your session or reboot to apply changes."
echo "You can adjust the scroll speed later in /etc/libinput.conf"
echo "------------------------------------------------"