#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

start

collect link ~/.gitconfig \
    --src src/git/gitconfig
collect link ~/.vimrc \
    --src src/vim/vimrc
collect link ~/.zshrc \
    --src src/zsh/zshrc \
    --force
collect link ~/.config/alacritty/alacritty.yml \
    --src src/alacritty/alacritty.yml \
    --create
collect link ~/.config/crestic/crestic.cfg \
    --src src/crestic/crestic.cfg \
    --create
collect link ~/.config/gh/config.yml \
    --src src/gh/config.yml \
    --create
collect link ~/.config/restic/exclude.txt \
    --src src/restic/exclude.txt \
    --create
collect link ~/.config/topgrade.toml \
    --src src/topgrade/topgrade.toml \
    --create
collect link ~/.gnupg/gpg-agent.conf \
    --if 'gpg -k' \
    --src src/gnupg/gpg-agent.conf

# macOS
collect link ~/Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json \
    --if '[ "$(uname -s)" = Darwin ]' \
    --src src/iterm/Profiles.json \
    --create

# Arch Linux with i3 window manager
collect link ~/.xinitrc \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/xinit/xinitrc \
    --create
collect link ~/.config/dunst/dunstrc \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/dunst/dunstrc \
    --create
collect link ~/.config/fontconfig/fonts.conf \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/fontconfig/fonts.conf \
    --create
collect link ~/.config/i3 \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/i3 \
    --create
collect link ~/.config/i3status-rust \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/i3status-rust \
    --create
collect link ~/.config/rofi \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/rofi \
    --create

report
