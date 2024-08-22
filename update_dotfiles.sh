#!/bin/bash

DOTFILES_DIR=$(pwd)

ITEMS_TO_COPY=(
  ~/.zshrc
  ~/.config/nvim
  ~/.p10k.zsh
  ~/.config/i3
  ~/.config/picom
  ~/.config/kitty
)

copy_item() {
  local item=$1

  local relative_path="${item/#$HOME\//}"

  local dest_path="$DOTFILES_DIR/$relative_path"

  mkdir -p "$(dirname "$dest_path")"

  if [ -d "$item" ]; then
    cp -r "$item" "$dest_path"
    echo "Directorio $item copiado a $dest_path"
  elif [ -f "$item" ]; then
    cp "$item" "$(dirname "$dest_path")"
    echo "Archivo $item copiado a $(dirname "$dest_path")"
  else
    echo "Error: $item no es un archivo ni un directorio válido."
  fi
}

for item in "${ITEMS_TO_COPY[@]}"; do
  copy_item "$item"
done

echo "Dotfiles actualizados."
