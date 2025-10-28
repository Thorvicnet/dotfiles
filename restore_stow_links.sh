#!/bin/bash

STOW_DIR="/home/thorvicnet/.config/custom"
TARGET_DIR="/home/thorvicnet/.config"

PACKAGES="btop foot gtk-3.0 mako zathura starship mimeapps zsh-syntax-highlighting"

echo "Restowing dotfiles from $STOW_DIR to $TARGET_DIR..."

cd "$STOW_DIR" || { echo "Error: Could not change to stow directory $STOW_DIR"; exit 1; }

for pkg in $PACKAGES; do
    echo "Stowing $pkg..."
    stow -v --restow -t "$TARGET_DIR" "$pkg"
    if [ $? -ne 0 ]; then
        echo "Warning: Stow failed for package $pkg. Please check for conflicts." >&2
    fi
done

echo "Stow process complete."
