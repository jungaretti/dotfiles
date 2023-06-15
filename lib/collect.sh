COLLECTED_ERROR=""

start() {
    COLLECTED_ERROR="false"
}

collect() {
    "$@" || COLLECTED_ERROR="true"
}

report() {
    if [ "$COLLECTED_ERROR" = "false" ]; then
        echo "All tasks completed successfully!"
    else
        echo -e "$(tput bold)$(tput setaf 1)Some tasks didn't complete successfully" >&2
        return 1
    fi
}
