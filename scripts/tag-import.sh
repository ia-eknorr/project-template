#!/bin/bash

# Set default values for optional arguments
DEFAULT_PROVIDER="default"
DEFAULT_POLICY="a"

# Initialize variables
PROVIDER="$DEFAULT_PROVIDER"
POLICY="$DEFAULT_POLICY"
RESTORED_FILES=0
FILE_PATH=""
FORCE_FLAG=false
HOST=""
LOG_FILE="tags/tag-import.log"

# Function to display script usage
display_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  --provider <provider>   Set the provider (default: $DEFAULT_PROVIDER)"
    echo "  --policy <policy>       Set the collision policy (default: $DEFAULT_POLICY)"
    echo "  --file, -f <file_path>  Specify the file or directory path to import"
    echo "  --force                 Force overwrite if collision policy is set to 'o'"
    echo "  --host <host>           Specify the host"
    echo "  -h, --help              Display this help message"
    exit 0
}

check_arguments() {
    if [ -z "$FILE_PATH" ]; then
        echo "Error: File path is required. Use --file or -f to specify the file path."
        exit 1
    fi
}

confirm_overwrite() {
    read -r -p "You've set POLICY to 'o' (overwrite) or 'd' (delete overwrite). Do you want to proceed? (y/n): " response
    case "$response" in
        [yY][eE][sS]|[yY])
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

log_import_status() {
    local timestamp
    timestamp=$(date +"%Y-%m-%d %H:%M:%S %Z")

    if [ ! -e "$LOG_FILE" ]; then
        printf "%-30s %-30s %-30s\n" "Timestamp" "File" "Status" >> "$LOG_FILE"
    fi

    printf "%-30s %-30s %-30s\n" "$timestamp" "$1" "$2" >> "$LOG_FILE"
}

construct_url() {
    local baseTagPath="$1"
    local hostname

    # Determine the host based on the environment
    if [ -f /.dockerenv ]; then
        hostname="${HOST}:8088"
    else
        hostname="${HOST}.localtest.me"
    fi

    # Construct the URL with or without baseTagPath
    if [ -z "$baseTagPath" ]; then
        echo "http://${hostname}/data/tag-cicd/tags/import?provider=${PROVIDER}&collisionPolicy=${POLICY}"
    else
        echo "http://${hostname}/data/tag-cicd/tags/import?provider=${PROVIDER}&baseTagPath=${baseTagPath}&collisionPolicy=${POLICY}"
    fi
}

post_tags() {
    local file_path
    file_path=$1
    local file_name
    file_name=$(basename -- "$file_path")
    local baseTagPath
    
    if [[ "$file_name" =~ (_types_|_.*_)\.json ]]; then
        baseTagPath=""
    else
        baseTagPath="${file_name%.*}"
    fi
    
    if [ -f "$file_path" ]; then
        curl_response=$(curl -sS -X POST -H "Content-Type: application/json" -d @"$file_path" "$(construct_url "$baseTagPath")")
        echo "$curl_response"
        ((RESTORED_FILES++))

        # Extract and count status types using regex
        good_count=$(echo "$curl_response" | grep -o 'Good' | wc -l)
        bad_failure_count=$(echo "$curl_response" | grep -o 'Bad_Failure' | wc -l)
        
        # Display the report at the end of each file
        echo -e "\nImport Status Report for $file_path:"
        echo "Good: $good_count"
        echo "Bad_Failure: $bad_failure_count"
        
        # Log the status report in the log file
        log_import_status "$file_path" "Good: ${good_count} Bad_Failure: ${bad_failure_count}"

    else
        echo "Error: Invalid file or directory path: $file_path"
        exit 1
    fi
}

import_tags() {
    # Check if the path is a directory
    if [ -d "$FILE_PATH" ]; then
        # Check if _types_.json exists
        if [ -e "$FILE_PATH/_types_.json" ]; then
            post_tags "$FILE_PATH/_types_.json"
        fi

        # Process other JSON files
        for json_file in "$FILE_PATH"/*.json; do
            # Skip _types_.json as they have already been processed
            if [ "$json_file" != "$FILE_PATH/_types_.json" ]; then
                post_tags "$json_file"
            fi
        done

    elif [ -f "$FILE_PATH" ] && [[ "$FILE_PATH" =~ \.json$ ]]; then
        post_tags "$FILE_PATH"
    else
        echo "Error: Invalid file or directory path: $FILE_PATH"
        exit 1
    fi
}

while [ "$#" -gt 0 ]; do
    case "$1" in
        --provider)
            shift
            PROVIDER="$1"
            ;;
        --policy)
            shift
            POLICY="$1"
            ;;
        --file | -f)
            shift
            FILE_PATH="$1"
            ;;
        --force)
            FORCE_FLAG=true
            ;;
        --host)
            shift
            HOST="$1"
            ;;
        --help | -h)
            display_help
            ;;
        *)
            break
            ;;
    esac
    shift
done

main() {
    echo "Running tag import with the following parameters:"
    echo "File Path: $FILE_PATH"
    echo "Host: $HOST"
    echo "Provider: ${PROVIDER:-default (Default)}"
    echo "Policy: ${POLICY:-o (Default)}"

    if [ "$POLICY" == "o" ] || [ "$POLICY" == "d" ]; then
        if [ "$FORCE_FLAG" == false ]; then
            confirm_overwrite || exit 0
        fi
    fi
    if [ -f /.dockerenv ]; then
        LOG_FILE="/$LOG_FILE"
    fi
    check_arguments
    import_tags

    # Display status report
    echo -e "\nRestored $RESTORED_FILES file(s)."
}

main
