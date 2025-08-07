#!/usr/bin/env bash

# A small script for symlinking dotfiles with stow

RED='\e[0;31m'
CYAN='\e[0;36m'
GREEN='\e[0;32m'
TXTRST='\e[0m'

if ! command -v stow &> /dev/null; then
    echo -e "${RED}Error: stow is not installed. Please install it first.${TXTRST}"
    exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

DOTFILES_DIR="$(dirname "$SCRIPT_DIR")/dots"

if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}Error: Cannot find dotfiles directory at $DOTFILES_DIR${TXTRST}"
    exit 1
fi

echo -e "Using dotfiles from: ${CYAN}$DOTFILES_DIR${TXTRST}"

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
            echo -e "${RED}Failed to $PRFX stow: $packageName${TXTRST}"
            FAILED=1
        fi
    fi
done

if [ "$FAILED" -eq 0 ]; then
    echo -e "${GREEN}Dotfiles $PRFX stowed successfully.${TXTRST}"
else
    echo -e "${RED}One or more packages failed to $PRFX stow.${TXTRST}"
    exit 1
fi
