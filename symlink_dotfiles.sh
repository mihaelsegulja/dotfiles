#!/usr/bin/env bash

# A small script for symlinking dotfiles with stow

for dir in */ ; do
    sleep 0.25
    folder_name=${dir%/}
    if [ -d "$folder_name" ]; then
        echo "Symlinking $folder_name"
        stow "$folder_name"
    fi
done

sleep 0.2
echo "Done."
