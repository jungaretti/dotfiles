COLLECTED_ERROR=""

start() {
    COLLECTED_ERROR="false"
}

collect() {
    (set -e -o pipefail; "$@")
    if [ "$?" -ne 0 ]; then
        COLLECTED_ERROR="true"
        echo -e "$(tput bold)$(tput setaf 1)WARNING: The task did not complete successfully$(tput sgr0)" >&2
    fi
}

report() {
    if [ "$COLLECTED_ERROR" = "false" ]; then
        echo "All tasks completed successfully!"
    else
        echo -e "$(tput bold)$(tput setaf 1)WARNING: Some tasks didn't complete successfully$(tput sgr0)" >&2
        return 1
    fi
}
