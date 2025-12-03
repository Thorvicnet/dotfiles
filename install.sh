#!/bin/bash

# Recreates all links

DOTFILES_DIR=~/dotfiles
CONFIG_DIR=~/.config

mkdir -p $CONFIG_DIR

# List of files and directories to link
files_to_link=(
  "zed"
  "foot"
  "gtk-3.0"
  "mako"
  "mimeapps"
  "starship"
  "zathura"
  "zsh-syntax-highlighting"
  ".zshrc"
  ".zprofile"
  "custom"
  "nvim"
  "fuzzel"
  "discordo"
  "mimeapps.list"
  "starship.toml"
)

for item in "${files_to_link[@]}"; do
  source_path="$DOTFILES_DIR/$item"
  target_path=""

  # target path
  if [[ "$item" == ".zshrc" || "$item" == ".zprofile" ]]; then
    target_path="$HOME/$item"
  else
    target_path="$CONFIG_DIR/$item"
  fi

  # Remove existing file or directory
  if [ -L "$target_path" ]; then
    rm -f "$target_path"
  elif [ -e "$target_path" ]; then
    rm -rf "$target_path"
  fi

  # Create the symbolic link
  ln -s "$source_path" "$target_path"
  echo "Linked $source_path to $target_path"
done

echo "Dotfiles installation complete."
