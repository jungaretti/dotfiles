#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

link ~/.config/alacritty/alacritty.yml -p src/alacritty/alacritty.yml -c
link ~/.vimrc -p src/vim/vimrc
link ~/.zshrc -p src/zsh/zshrc
