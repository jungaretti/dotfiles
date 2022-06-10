#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

link ~/.vimrc -s src/vim/vimrc
link ~/.zshrc -s src/zsh/zshrc
link ~/.config/alacritty/alacritty.yml -s src/alacritty/alacritty.yml -c
link ~/.gnupg/gpg-agent.conf -s src/gnupg/gpg-agent.conf --if 'gpg -k'
