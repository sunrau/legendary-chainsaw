#!/bin/bash

set -e  # Exit on error

# Update system and install base development tools
echo "Updating system and installing base-devel..."
sudo pacman -Syu --needed git base-devel

# Clone and install yay
echo "Cloning yay from AUR..."
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# Clean up
cd ..
rm -rf yay

# Install packages with yay
echo "Installing packages with yay..."
yay -Syu --needed \
  ninja gcc cmake meson libxcb xcb-proto xcb-util xcb-util-keysyms \
  libxfixes libx11 libxcomposite libxrender libxcursor pixman \
  wayland-protocols cairo pango libxkbcommon xcb-util-wm xorg-xwayland \
  libinput libliftoff libdisplay-info cpio tomlplusplus hyprlang-git \
  hyprcursor-git hyprwayland-scanner-git xcb-util-errors hyprutils-git \
  glaze hyprgraphics-git aquamarine-git re2 hyprland-qtutils hyprland-meta-git

echo "Done!"
