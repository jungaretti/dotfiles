#!/usr/bin/env bash

set -e

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

cd "${BASEDIR}"
source "./scripts/dots.sh"

link -s ./src/zsh/zshrc -d ~/.zshrc
