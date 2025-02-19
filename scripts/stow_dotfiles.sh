#!/usr/bin/env bash

# A small script for symlinking dotfiles with stow

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed. Please install it first."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTFILES_DIR="$(dirname "$SCRIPT_DIR")/dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Cannot find dotfiles directory at $DOTFILES_DIR"
    exit 1
fi

echo "Using dotfiles from: $DOTFILES_DIR"

for package in "$DOTFILES_DIR"/*; do
    if [ -d "$package" ]; then
        packageName="$(basename "$package")"
        echo "Stowing package: $packageName"
        stow -d "$DOTFILES_DIR" -t "$HOME" "$packageName"
    fi
done

echo "Dotfiles stowed successfully."
