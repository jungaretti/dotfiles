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

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Instaling dotfiles..."
pushd "${BASEDIR}"

DOTFILES_EXIT_CODE=0

link "$HOME/.gitconfig" \
    --src src/git/gitconfig
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.gitconfig"" >&2
    DOTFILES_EXIT_CODE=2
fi

link "$HOME/.vimrc" \
    --src src/vim/vimrc
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.vimrc"" >&2
    DOTFILES_EXIT_CODE=3
fi

link "$HOME/.zshrc" \
    --src src/zsh/zshrc \
    --force
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.zshrc"" >&2
    DOTFILES_EXIT_CODE=4
fi

link "$HOME/.config/crestic/config.cfg" \
    --src src/crestic/config.cfg \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.config/crestic/config.cfg"" >&2
    DOTFILES_EXIT_CODE=5
fi

link "$HOME/.config/gh/config.yml" \
    --src src/gh/config.yml \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.config/gh/config.yml"" >&2
    DOTFILES_EXIT_CODE=6
fi

link "$HOME/.config/restic/exclude.txt" \
    --src src/restic/exclude.txt \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.config/restic/exclude.txt"" >&2
    DOTFILES_EXIT_CODE=7
fi

link "$HOME/.gnupg/gpg-agent.conf" \
    --if 'gpg -k' \
    --src src/gnupg/gpg-agent.conf
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.gnupg/gpg-agent.conf"" >&2
    DOTFILES_EXIT_CODE=8
fi

link "$HOME/.ssh/config" \
    --src src/ssh/config \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.ssh/config"" >&2
    DOTFILES_EXIT_CODE=9
fi

link "$HOME/.config/bat/config" \
    --src src/bat/config \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/.ssh/config"" >&2
    DOTFILES_EXIT_CODE=11
fi

# macOS
link "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Profiles.json" \
    --if '[ "$(uname -s)" = Darwin ]' \
    --src src/iterm/Profiles.json \
    --create
if [ "$?" -ne 0 ]; then
    echo -e "ERROR: Could install dotfile "$HOME/Library/Application Support/iTerm2/DynamicProfiles/Profiles.json"" >&2
    DOTFILES_EXIT_CODE=10
fi

exit $DOTFILES_EXIT_CODE
