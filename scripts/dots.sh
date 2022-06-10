#!/bin/bash

link() {
	SRC=""
	DEST=""
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
		-* | --*)
			echo "Unknown option: $1"
			exit 1
			;;
		*)
			ARGS+=("$1")
			shift
			;;
		esac
	done

	SRC="$(readlink -f $SRC)"

	if [ -e "$DEST" ]; then
		echo "Destination already exists: $DEST"
		exit 1
	fi

	if [ ! -e "$SRC" ]; then
		echo "Source does not exist: $SRC"
		exit 1
	fi

	echo "Creating link from $SRC to $DEST..."
	ln -s "$SRC" "$DEST"
}
