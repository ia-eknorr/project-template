#!/bin/bash

set -eo pipefail

# shellcheck disable=SC1091
source ".env"

for provider_path in tags/*; do
    provider=$(basename "$provider_path")
    host="${GATEWAY_NAME}.localtest.me"
    echo "$provider $host"

    scripts/tag-export.sh -d -p "$provider" "$host"
done
echo ""