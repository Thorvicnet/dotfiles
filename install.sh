#!/bin/bash

# This script creates symbolic links from the home directory to the files in the dotfiles directory.

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

# Create .config directory if it doesn't exist
mkdir -p $CONFIG_DIR

# List of files and directories to link
files_to_link=(
    "btop"
    "foot"
    "gtk-3.0"
    "mako"
    "mimeapps"
    "starship"
    "xdg"
    "zathura"
    "zsh-syntax-highlighting"
    ".zshrc"
    ".zprofile"
    "nix-shell"
    "proxy.sh"
)

# Link files and directories
for item in "${files_to_link[@]}"; do
    source_path="$DOTFILES_DIR/$item"
    target_path=""

    # Determine the target path
    if [[ "$item" == ".zshrc" || "$item" == ".zprofile" ]]; then
        target_path="$HOME/$item"
    else
        target_path="$CONFIG_DIR/$item"
    fi

    # Remove existing file or directory if it's not a symlink
    if [ -e "$target_path" ] && [ ! -L "$target_path" ]; then
        echo "Backing up and removing existing $target_path"
        mv "$target_path" "$target_path.bak"
    fi

    # Create the symbolic link
    ln -sf "$source_path" "$target_path"
    echo "Linked $source_path to $target_path"
done

echo "Dotfiles installation complete."
