#!/bin/bash

collect() {
	"$@" || FAILURE="true"
}

start() {
	export FAILURE="false"
}

report() {
	if [ "$FAILURE" = "false" ]; then
		echo "All tasks completed successfully!"
	else
		echo "Some tasks didn't complete successfully"
		return 1
	fi
}

link() {
	SRC=""
	CREATE="false"
	RELINK="false"
	FORCE="false"
	IF=""
	# RELATIVE=""

	ARGS=()
	while [[ $# -gt 0 ]]; do
		case $1 in
		-s | --src)
			SRC="$2"
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

	SRC="$(readlink -f "$SRC")"
	DEST="${ARGS[0]}"

	# Make sure source exists
	if [ ! -e "$SRC" ]; then
		echo "Source does not exist: $SRC"
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
