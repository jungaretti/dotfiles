#!/bin/bash

link() {
  SRC="$1"
  DEST="$2"
  # CREATE=""
  # RELINK=""
  # FORCE=""
  # IF=""
  # RELATIVE=""
  # CONONICALIZE=""
  # IGNORE_MISSING=""
  # GLOB=""
  # EXCLUDE=""
  # PREFIX=""

  echo "Creating link from $SRC to $DEST..."

  if [ -e "$DEST" ]; then
    echo "Destination already exists: $DEST"
    exit 1
  fi

  if [ ! -e "$SRC" ]; then
    echo "Source does not exist: $SRC"
    exit 1
  fi

  ln -s "$SRC" "$DEST"
}
