#!/usr/bin/env bash

# A small script for symlinking dotfiles with stow

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed. Please install it first."
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTFILES_DIR="$(dirname "$SCRIPT_DIR")/dots"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo "Error: Cannot find dotfiles directory at $DOTFILES_DIR"
    exit 1
fi

echo "Using dotfiles from: $DOTFILES_DIR"

FLAG="-S"
PRFX=""

if [[ "$1" == "-D" || "$1" == "--unstow" ]]; then
    FLAG="-D"
    PRFX="un"
fi

FAILED=0

for package in "$DOTFILES_DIR"/*; do
    if [ -d "$package" ]; then
        packageName="$(basename "$package")"
        echo "Processing package: $packageName"
        if ! stow "$FLAG" -d "$DOTFILES_DIR" -t "$HOME" "$packageName"; then
            echo "Failed to $PRFX stow: $packageName"
            FAILED=1
        fi
    fi
done

if [ "$FAILED" -eq 0 ]; then
    echo "Dotfiles $PRFX stowed successfully."
else
    echo "One or more packages failed to $PRFX stow."
    exit 1
fi
