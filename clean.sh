#!/bin/bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${BASEDIR}/lib/collect.sh"

clean() {
    local recurse="false"

    local args=()
    while [[ $# -gt 0 ]]; do
        case $1 in
            -r | --recurse)
                recurse="true"
                shift
                ;;
            -* | --*)
                echo "Unknown option: $1"
                return 1
                ;;
            *)
                args+=("$1")
                shift
                ;;
        esac
    done

    # Make sure directory exists
    local dir="${args[0]}"
    if [ ! -d "$dir" ]; then
        echo "Directory does not exist: $dir"
        return 1
    fi

    # Use --max-depth to avoid excessive recursion
    local fd_args=()
    if [ "$recurse" = "false" ]; then
        fd_args+=("--max-depth" "1")
    fi

    fd "${fd_args[@]}" --hidden --type l --search-path "$dir" | while read symlink; do
        local target="$(readlink "$symlink")"

        # Only clean symlinks that point to these dotfiles
        if [[ "$target" != "$BASEDIR"* ]]; then
            continue
        fi

        if [ -e "$target" ]; then
            echo "Healthy symlink: $symlink -> $target"
            continue
        fi

        echo "Removing broken symlink: $symlink -> $target"
        rm "$symlink"
    done
}

echo "Cleaning dotfile symlinks..."
pushd "${BASEDIR}"

start

collect clean --recurse "$HOME/.config"
collect clean "$HOME"

report
