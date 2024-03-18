#!/bin/bash

FOLDERS_TO_CHECK=("_types_" "Exchange")

get_absolute_path() {
  local script_path="$1"
  dirname "$(realpath "$script_path")"
}

parse_environment() {
  local env_file="$1"
  ENV_FILE="${env_file:-$(realpath "$env_file")}"

  while IFS='=' read -r key value; do
    case "$key" in
      GATEWAY_NAME|ENV)
        eval "$key=\"${value//\"/}\""
        ;;
    esac
  done < "$ENV_FILE"

  if [ -z "$GATEWAY_NAME" ] || [ -z "$ENV" ]; then
    echo "Error: Missing required variables. Please check your .env file."
    exit 1
  fi
}

construct_url() {
  local gateway_name="$1"
  local env="$2"
  local base_path="$3"
  echo "http://${gateway_name}-${env}.localtest.me/data/tag-cicd/tags/export?recursive=true&baseTagPath=$base_path&individualFilesPerObject=true"
}

process_url() {
  local url_name="$1"
  local base_path="$2"
  local output_file="tags/${base_path}.json"

  URL=$(construct_url "$GATEWAY_NAME" "$ENV" "$base_path")
  echo "Constructed URL for $url_name: $URL"

  curl "$URL" -o "$output_file"
}

format_json() {
  local json_file="$1"
  if command -v python3 &> /dev/null; then
    python3 -c "import json; data = json.load(open('$json_file')); formatted_data = json.dumps(data, indent=2); open('$json_file', 'w').write(formatted_data)"
    echo "Formatted JSON saved to $json_file"
  else
    echo "Error: Python 3 is required for JSON formatting, but it is not installed."
  fi
}

main() {
  echo "Beginning tag export"

  ENV_FILE=$(get_absolute_path "$0")/../.env
  parse_environment "$ENV_FILE"

  for folder in "${FOLDERS_TO_CHECK[@]}"; do
    process_url "$folder" "$folder"
    format_json "tags/${folder}.json"
  done
}

main
