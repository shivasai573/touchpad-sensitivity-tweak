
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

# 🖱️ touchpad-sensitivity-tweak

A universal bash script to adjust touchpad scroll sensitivity for Linux distributions using GNOME (Fedora, Ubuntu, Arch, etc.).
## ❓ The Problem
Many Linux distributions, particularly those running GNOME, do not offer a native GUI slider to adjust the touchpad scrolling speed. For many laptops, the default "scroll factor" is far too sensitive, making navigation difficult and erratic.

## 🚀 The Solution
This project automates the installation of `libinput-config` and allows you to set a custom `scroll-factor` (defaulting to **0.3**) to make scrolling feel natural and precise across different distributions.

## 🛠️ Supported Distributions
The script automatically detects your package manager and installs the necessary dependencies:
* **Arch Linux** (`pacman`)
* **Fedora** (`dnf`)
* **Ubuntu / Debian** (`apt`)

## 📦 Installation

**1. Clone the repository:**
```bash
git clone https://github.com/shivasai573/touchpad-sensitivity-tweak.git
cd touchpad-sensitivity-tweak
````

**2. Make the script executable:**

```bash
chmod +x scripts/install_fix.sh
```

**3. Run the installer:**

```bash
sudo ./scripts/install_fix.sh
```

**4. Apply the changes:** Log out of your current session and log back in (or restart your computer) to see the changes take effect.

---
## ⚙️ Customization

If you find that the default **0.3** is still too fast or too slow, you can manually edit the configuration file created by the script:

```bash
sudo nano /etc/libinput.conf
```

Change the `scroll-factor` value (e.g., `0.2` for slower, `0.5` for faster), save the file, and restart your session.

---

> ⚠️ **Important:** You must **uninstall `touchegg`** before using this package. The two tools conflict, and this tweak will not function correctly if `touchegg` is present on your system.

To uninstall **touchegg**:
<details>
<summary>Arch Linux</summary>

```bash
sudo pacman -Rns touchegg
```

</details>
<details>
<summary>Fedora</summary>

```bash
sudo dnf remove touchegg
```

</details>
<details>
<summary>Ubuntu / Debian</summary>

```bash
sudo apt remove --purge touchegg
```

</details>

## ⏪ Reverting Changes

If you want to undo the tweak and return to your default settings, simply remove the configuration file:

```bash
sudo rm /etc/libinput.conf
```

_Don't forget to restart your session after removing the file!_

---

**Credits:** This project utilizes the excellent `libinput-config` utility created by [@warningnonpotablewater](https://gitlab.com/warningnonpotablewater)

 ⭐ **If this tweak helped you, please consider giving the repository a star to help others find it!**
