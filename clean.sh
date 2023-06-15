#!/bin/bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEBUG="true"

clean() {
    local dir="$1"
    
    fd --type l --search-path "$dir" | while read symlink; do
        local target="$(readlink "$symlink")"

        # Only clean symlinks that point to these dotfiles
        if [[ "$target" != "$BASEDIR"* ]]; then
            continue
        fi

        if [ -e "$target" ]; then
            echo "Working link: $symlink -> $target"
            continue
        fi

        echo "Removing broken symlink: $symlink -> $target"
        rm "$symlink"
    done
}

echo "Cleaning dotfile symlinks..."
clean "$HOME/.config"
# clean "$HOME"
