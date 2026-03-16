#!/bin/bash

# Exit immediately if a command fails, treat unset variables as errors
set -euo pipefail

echo "🚀 Starting the Universal Touchpad Scroll Fix..."

# 1. Check for Root Privileges
if [ "$EUID" -ne 0 ]; then
  echo "❌ Error: Please run this script with sudo (e.g., sudo bash $0)"
  exit 1
fi

# 2. Detect Distribution and Install Dependencies
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
else
    echo "❌ Error: Cannot detect Linux distribution."
    exit 1
fi

echo "📦 Detecting dependencies for $PRETTY_NAME..."

case "$OS" in
    fedora)
        dnf install -y meson ninja-build libinput-devel git gcc gcc-c++ make
        ;;
    ubuntu|debian|linuxmint|pop)
        apt update && apt install -y meson ninja-build libinput-dev git gcc g++ make
        ;;
    arch|manjaro)
        pacman -S --needed --noconfirm meson ninja libinput git gcc make
        ;;
    *)
        echo "⚠️  Unknown distribution ($OS). Please ensure meson, ninja, and libinput headers are installed."
        ;;
esac

# 3. Clean up and Setup
[ -d "libinput-config" ] && echo "🧹 Cleaning up old files..." && rm -rf libinput-config

# 4. Clone the working mirror
echo "📥 Cloning dependency from GitHub mirror..."
git clone https://github.com/lz42/libinput-config.git
cd libinput-config

# 5. Build the project
echo "🔨 Building project with Meson..."
meson setup build
ninja -C build

# 6. Install
echo "🛠️  Installing to system..."
ninja -C build install

# 7. Apply the 0.3 Scroll Factor
echo "⚙️  Configuring scroll speed..."
cat <<EOF > /etc/libinput.conf
# libinput-config configuration
override-compositor=enabled

# Fixed scroll speed (0.3 or 0.5 is your preferred slower speed)
scroll-factor=0.3

tap=enabled
natural-scroll=disabled
EOF

echo "------------------------------------------------"
echo "✅ Success! Please RESTART your session to apply changes."
echo "Your config is saved at: /etc/libinput.conf"
echo "------------------------------------------------"
