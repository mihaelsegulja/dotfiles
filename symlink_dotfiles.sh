#!/usr/bin/env bash

# A small script for symlinking dotfiles with stow

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed. Please install it first."
    exit 1
fi

for dir in */ ; do
    folder_name=${dir%/}
    if [ -d "$folder_name" ]; then
        echo "Symlinking $folder_name"
        stow "$folder_name"
    fi
done

echo "Done."
