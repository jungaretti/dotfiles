#!/bin/bash

start() {
	export FAILURE="false"
}

collect() {
	"$@" || FAILURE="true"
}

report() {
	if [ "$FAILURE" = "false" ]; then
		echo "All tasks completed successfully!" >&2
	else
		echo -e "$(tput bold)$(tput setaf 1)Some tasks didn't complete successfully" >&2
		return 1
	fi
}

link() {
	SRC_REL=""
	CREATE="false"
	RELINK="false"
	FORCE="false"
	IF=""
	# RELATIVE=""

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
