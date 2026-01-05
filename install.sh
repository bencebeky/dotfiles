#!/usr/bin/env bash

set -euo pipefail

# symlink dotfiles

DOTFILES_PATH="$HOME/dotfiles"
find $DOTFILES_PATH -type f -path "$DOTFILES_PATH/.*" |
while read df; do
  link=${df/$DOTFILES_PATH/$HOME}
  mkdir -p "$(dirname "$link")"
  ln -sf "$df" "$link"
done

# copy .aptitude/config

sudo mkdir -p /root/.aptitude
sudo cp $DOTFILES_PATH/aptitude-config /root/.aptitude/config
sudo chown root.root /root/.aptitude/config

# configure GitHub CLI repository

sudo mkdir -p -m 755 /etc/apt/keyrings
out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg
cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null
sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg
sudo mkdir -p -m 755 /etc/apt/sources.list.d
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

# install some packages

sudo apt-get update
sudo apt-get install -y \
    apt-utils \
    aptitude \
    bash-completion \
    inetutils-ping \
    inetutils-telnet \
    inetutils-traceroute \
    dnsutils \
    fzf \
    gh \
    libtinfo5 \
    python3-numpy \
    renameutils \
    tmux \
    vim

# git config

git config --global alias.co checkout
git config --global push.autoSetupRemote true
git config --global color.diff.new "brightgreen bold"
git config --global color.diff.old "brightred bold"
