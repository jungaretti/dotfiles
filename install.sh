#!/bin/bash

link() {
    SRC_REL=""
    CREATE="false"
    RELINK="false"
    FORCE="false"
    IF=""

    ARGS=()
    while [[ $# -gt 0 ]]; do
        case $1 in
            -s | --src)
                SRC_REL="$2"
                shift
                shift
                ;;
            -c | --create)
                CREATE="true"
                shift
                ;;
            -r | --relink)
                RELINK="true"
                shift
                ;;
            -f | --force)
                FORCE="true"
                shift
                ;;
            --if)
                IF="$2"
                shift
                shift
                ;;
            -* | --*)
                echo "Unknown option: $1"
                return 1
                ;;
            *)
                ARGS+=("$1")
                shift
                ;;
        esac
    done

    DEST="${ARGS[0]}"
    SRC="$(readlink -f "$SRC_REL")"

    # Make sure source exists
    if [ ! -e "$SRC" ]; then
        echo "Source does not exist: $SRC_REL"
        return 1
    fi

    # Evaluate condition and skip if false
    if [ -n "$IF" ] && ! bash -c "$IF" &>/dev/null; then
        echo "Skipping: $SRC"
        return
    fi

    # Skip if valid link already exists
    if [ "$(readlink -f "$DEST")" = "$SRC" ]; then
        echo "Link already exists: $DEST -> $SRC"
        return
    fi

    # Remove existing destination (if needed)
    if [ "$RELINK" = "true" ] || [ "$FORCE" = "true" ] && [ -L "$DEST" ]; then
        echo "Removing existing link: $DEST"
        rm $DEST
    fi
    if [ "$FORCE" = "true" ] && [ -e "$DEST" ]; then
        echo "Removing existing file: $DEST"
        rm $DEST
    fi

    # Make sure destination doesn't exist
    if [ -e "$DEST" ]; then
        echo "Destination already exists: $DEST"
        return 1
    fi

    # Create parent directory (if needed)
    DEST_DIR="$(dirname "$DEST")"
    if [ "$CREATE" = "true" ] && [ ! -d "$DEST_DIR" ]; then
        echo "Creating parent directory: $DEST_DIR"
        mkdir -p "$DEST_DIR"
    fi

    echo "Creating link: $SRC -> $DEST"
    ln -s "$SRC" "$DEST"
}

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${BASEDIR}/lib/collect.sh"

echo "Instaling dotfiles..."
pushd "${BASEDIR}"

set +e

start

collect link ~/.gitconfig \
    --src src/git/gitconfig
collect link ~/.vimrc \
    --src src/vim/vimrc
collect link ~/.zshrc \
    --src src/zsh/zshrc \
    --force
collect link ~/.config/crestic/config.cfg \
    --src src/crestic/config.cfg \
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
collect link ~/.ssh/config \
    --if 'command -v ssh' \
    --src src/ssh/config

# macOS
collect link ~/Library/Application\ Support/iTerm2/DynamicProfiles/Profiles.json \
    --if '[ "$(uname -s)" = Darwin ]' \
    --src src/iterm/Profiles.json \
    --create

report
