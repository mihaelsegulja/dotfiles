#!/usr/bin/env bash
set -e

echo "=== Adding required repositories ==="

# Add Microsoft .NET repo
sudo zypper ar -f https://packages.microsoft.com/opensuse/15/prod/ dotnet

# Add VSCode repo
sudo zypper ar -f https://packages.microsoft.com/yumrepos/vscode vscode

# Add Packman repo for multimedia / extra codecs
sudo zypper ar -f https://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman

# Add KDE:Extra 
sudo zypper ar -f https://download.opensuse.org/repositories/KDE:/Extra/openSUSE_Tumbleweed/ KDE_Extra

# Add MEGAsync
sudo zypper ar -f https://mega.nz/linux/repo/openSUSE_Tumbleweed/ MEGAsync

# Add VSCode ide repo
sudo zypper ar -f https://download.opensuse.org/repositories/devel:/tools:/ide:/vscode/openSUSE_Tumbleweed devel_tools_ide_vscode

# Add games/tools repo
sudo zypper ar -f https://download.opensuse.org/repositories/games:/tools/openSUSE_Tumbleweed/ games_tools

sudo zypper refresh

echo "=== Installing packages ==="

sudo zypper install -y \
    git \
    zsh \
    curl \
    wget \
    stow \
    neovim \
    fastfetch \
    tmux \
    btop \
    lazygit \
    lazydocker \
    ripgrep \
    fzf \
    bat \
    eza \
    unzip \
    zip \
    gcc \
    gcc-c++ \
    make \
    cmake \
    docker \
    docker-compose \
    nodejs22 \
    npm22 \
    python3 \
    python3-pip \
    dotnet-sdk-8.0 \
    code \
    yazi \
    symbols-only-nerd-fonts \
    powerline-fonts \
    mozilla-fira-fonts \
    fontawesome-fonts \
    fira-code-fonts \
    powerline-fonts \

echo "=== Packages installed successfully ==="

