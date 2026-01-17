#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "Starting the touchpad sensitivity fix..."

# 1. Clean up any previous failed attempts
if [ -d "libinput-config" ]; then
    echo "Removing old dependency folder..."
    rm -rf libinput-config
fi

# 2. Clone the working fork
echo "Cloning dependency from ian-ross mirror..."
if git clone https://github.com/lz42/libinput-config.git; then
    cd libinput-config
else
    echo "ERROR: Failed to clone the repository. Check your internet connection."
    exit 1
fi

# 3. Build the project using Meson and Ninja
echo "Building the project..."
# Using 'meson setup' as 'meson' alone is deprecated
meson setup build || { echo "Meson setup failed. Do you have meson installed?"; exit 1; }

echo "Compiling..."
ninja -C build || { echo "Ninja build failed. Do you have ninja-build installed?"; exit 1; }

# 4. Install (requires sudo)
echo "Installing to system..."
sudo ninja -C build install || { echo "Installation failed at the system level."; exit 1; }

# 5. Apply the tweak
echo "Applying sensitivity tweak..."
# Add your specific libinput-config commands here if needed, 
# or let the user know to restart.

echo "------------------------------------------------"
echo "Done! Please restart your session to apply changes."
echo "------------------------------------------------"