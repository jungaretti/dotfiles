#!/bin/bash

link() {
	SRC=""
	DEST=""
	CREATE=""
	# RELINK=""
	# FORCE=""
	# IF=""
	# RELATIVE=""
	# CONONICALIZE=""
	# IGNORE_MISSING=""
	# GLOB=""
	# EXCLUDE=""
	# PREFIX=""

	ARGS=()
	while [[ $# -gt 0 ]]; do
		case $1 in
		-s | --src)
			SRC="$2"
			shift
			shift
			;;
		-d | --destination)
			DEST="$2"
			shift
			shift
			;;
		-c | --create)
			CREATE='true'
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

	SRC="$(readlink -f $SRC)"

	if [ ! -e "$SRC" ]; then
		echo "Source does not exist: $SRC"
		return 1
	fi

	if [ "$(readlink -f $DEST)" = "$SRC" ]; then
		echo "Link already exists: $DEST -> $SRC"
		return
	fi

	if [ -e "$DEST" ]; then
		echo "Destination already exists: $DEST"
		return 1
	fi

	DEST_DIR="$(dirname $DEST)"
	if [ "$CREATE" = "true" ] && [ ! -d "$DEST_DIR" ]; then
		echo "Creating parent directory: $DEST_DIR"
		mkdir -p "$DEST_DIR"
	fi

	echo "Creating link $SRC -> $DEST"
	ln -s "$SRC" "$DEST"
}
