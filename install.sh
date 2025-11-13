#!/usr/bin/env bash

set -euo pipefail

DOTFILES_PATH="$HOME/dotfiles"

find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
while read df; do
  link=${df/$DOTFILES_PATH/$HOME}
  mkdir -p "$(dirname "$link")"
  ln -sf "$df" "$link"
done

apt-get update
apt-get install vim renameutils
