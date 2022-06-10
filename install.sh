#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

link ~/.vimrc -p src/vim/vimrc
link ~/.zshrc -p src/zsh/zshrc
link ~/.config/alacritty/alacritty.yml -p src/alacritty/alacritty.yml -c
link ~/.gnupg/gpg-agent.conf -p src/gnupg/gpg-agent.conf --if 'gpg -k'
