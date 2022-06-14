#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

set +e

link ~/.gitconfig \
    --src src/git/gitconfig
link ~/.vimrc \
    --src src/vim/vimrc
link ~/.zshrc \
    --src src/zsh/zshrc \
    --force
link ~/.config/alacritty/alacritty.yml \
    --src src/alacritty/alacritty.yml \
    --create
link ~/.config/crestic/crestic.cfg \
    --src src/crestic/crestic.cfg \
    --create
link ~/.config/gh/config.yml \
    --src src/gh/config.yml \
    --create
link ~/.config/restic/exclude.txt \
    --src src/restic/exclude.txt \
    --create
link ~/.config/topgrade.toml \
    --src src/topgrade/topgrade.toml \
    --create
link ~/.gnupg/gpg-agent.conf \
    --if 'gpg -k' \
    --src src/gnupg/gpg-agent.conf
