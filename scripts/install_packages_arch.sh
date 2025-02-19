#!/usr/bin/env bash

# A small script for installing arch packages

PACKAGE_LIST="pkglists/pkglist.txt"
FLATPAK_PACKAGE_LIST="pkglists/flatpak-pkglist.txt"

is_yay_installed() {
    if ! command -v yay &>/dev/null; then
        echo "yay is not installed. Installing yay..."
        install_yay
    else
        echo "yay is already installed."
    fi
}

install_yay() {
    sudo pacman -S --needed --noconfirm git base-devel
    git clone https://aur.archlinux.org/yay.git || { echo "Failed to clone yay repository."; exit 1; }
    cd yay || exit
    makepkg -si --noconfirm || { echo "Failed to build and install yay."; exit 1; }
    cd ..
    rm -rf yay
    echo "yay has been installed successfully."
}

update_system() {
    echo "Updating system..."
    sudo pacman -Syu --noconfirm || { echo "System update failed."; exit 1; }
    echo "System updated successfully!"
}

install_packages() {
    if [ ! -f "$PACKAGE_LIST" ]; then
        echo "Error: Package list file '$PACKAGE_LIST' not found."
        exit 1
    fi
    
    echo "Installing packages from $PACKAGE_LIST..."
    yay -S --needed - < "$PACKAGE_LIST" || { echo "Failed to install some packages."; exit 1; }

    echo "All packages have been installed successfully!"
}

install_flatpak_packages() {
    if [ ! -f "$FLATPAK_PACKAGE_LIST" ]; then
        echo "Error: Flatpak package list file '$FLATPAK_PACKAGE_LIST' not found."
        return 1
    fi

    while read -r package; do
        if [ -n "$package" ]; then
            echo "Installing Flatpak package: $package"
            flatpak install --noninteractive flathub "$package" || { echo "Failed to install Flatpak package: $package"; continue; }
        fi
    done < "$FLATPAK_PACKAGE_LIST"

    echo "All Flatpak packages have been installed successfully!"
}

# Main script execution
is_yay_installed
update_system
install_packages
install_flatpak_packages
