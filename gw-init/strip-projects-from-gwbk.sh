#!/usr/bin/env bash
set -eo pipefail

# Set up environment
apt-get update
#DEBIAN_FRONTEND=noninteractive 
apt-get install -y --no-install-recommends git sqlite3 unzip zip ca-certificates jq
rm -rf /var/lib/apt/lists/*

function strip_from_single_gwbk() {
    ZIP_FILE="$1"
    zip -d "${ZIP_FILE}" "projects/*" > /dev/null 2>&1 || \
        if [[ ${ZIP_EXIT_CODE:=$?} == 12 ]]; then \
            echo "INFO: No projects folder found in gwbk ${ZIP_FILE}."; \
        else \
            echo "ERROR: Unknown error (${ZIP_EXIT_CODE}) encountered during interaction with ${ZIP_FILE}, exiting." && \
            exit "${ZIP_EXIT_CODE}"; \
        fi
}

function strip_from_all_gwbks() {
    readarray -d '' zip_files < <(find . -name "*.gwbk" -print0)
    for ZIP_FILE in "${zip_files[@]}"; do
        strip_from_single_gwbk "${ZIP_FILE}"
    done
}

###############################################################################
# Print usage information
###############################################################################
function usage() {
  >&2 echo "Usage: $0 [-f <gwbk file>]|[-a]"
}

while getopts ":f:a" opt; do
    case ${opt} in
    f)
        strip_from_single_gwbk "${OPTARG}";;
    a)
        strip_from_all_gwbks;;
    \?)
        usage
        echo "Invalid option: -${OPTARG}" >&2
        exit 1;;
    :)
        usage
        echo "Invalid option: -${OPTARG} requires an argument" >&2
        exit 1;;
    *)
        usage
        exit 1;;
    esac
done

if [[ ${OPTIND} -eq 1 ]]; then
    usage
    exit 1
fi