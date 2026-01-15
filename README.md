# 🖱️ touchpad-sensitivity-tweak

A universal bash script to adjust touchpad scroll sensitivity for Linux distributions using GNOME (Fedora, Ubuntu, Arch, etc.).

## ❓ The Problem
Many Linux distributions, particularly those running GNOME, do not offer a native GUI slider to adjust the touchpad scrolling speed. For many laptops, the default "scroll factor" is far too sensitive, making navigation difficult and erratic.

## 🚀 The Solution
This project automates the installation of `libinput-config` and allows you to set a custom `scroll-factor` (defaulting to **0.3**) to make scrolling feel natural and precise across different distributions.

## 🛠️ Supported Distributions
The script automatically detects your package manager and installs the necessary dependencies:
- **Fedora** (dnf)
- **Ubuntu/Debian** (apt)
- **Arch Linux** (pacman)

## 📦 Installation

1. **Clone the repository:**

   git clone [https://github.com/YOUR_USERNAME/touchpad-sensitivity-tweak.git](https://github.com/YOUR_USERNAME/touchpad-sensitivity-tweak.git)
   cd touchpad-sensitivity-tweak

2. **Make the script executable:**

Bash

chmod +x scripts/install_fix.sh

3. **Run the installer:**

sudo ./scripts/install_fix.sh


Apply Changes: Log out of your current session and log back in (or restart) to see the changes.

4. **Customization**
If you find that 0.3 is still too fast or too slow, you can manually edit the configuration file created by the script:

Bash

sudo nano /etc/libinput.conf

Change the scroll-factor value (e.g., 0.2 for even slower, 0.5 for faster), save, and restart your session.

This project utilizes the excellent libinput-config utility created by warningnoname.