#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

reset_failure
collect_failure link ~/.gitconfig \
    --src src/git/gitconfig
collect_failure link ~/.vimrc \
    --src src/vim/vimrc
collect_failure link ~/.zshrc \
    --src src/zsh/zshrc \
    --force
collect_failure link ~/.config/alacritty/alacritty.yml \
    --src src/alacritty/alacritty.yml \
    --create
collect_failure link ~/.config/crestic/crestic.cfg \
    --src src/crestic/crestic.cfg \
    --create
collect_failure link ~/.config/gh/config.yml \
    --src src/gh/config.yml \
    --create
collect_failure link ~/.config/restic/exclude.txt \
    --src src/restic/exclude.txt \
    --create
collect_failure link ~/.config/topgrade.toml \
    --src src/topgrade/topgrade.toml \
    --create
collect_failure link ~/.gnupg/gpg-agent.conf \
    --if 'gpg -k' \
    --src src/gnupg/gpg-agent.conf

# macOS
collect_failure link ~/Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json \
    --if '[ "$(uname -s)" = Darwin ]' \
    --src src/iterm/Profiles.json \
    --create

# Arch Linux with i3 window manager
collect_failure link ~/.xinitrc \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/xinit/xinitrc \
    --create
collect_failure link ~/.config/dunst/dunstrc \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/dunst/dunstrc \
    --create
collect_failure link ~/.config/fontconfig/fonts.conf \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/fontconfig/fonts.conf \
    --create
collect_failure link ~/.config/i3 \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/i3 \
    --create
collect_failure link ~/.config/i3status-rust \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/i3status-rust \
    --create
collect_failure link ~/.config/rofi \
    --if '[ "$USE_CUSTOM_WM" = "true" ]' \
    --src src/rofi \
    --create
report_failure
