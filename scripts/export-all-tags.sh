#!/bin/bash

set -eo pipefail

# shellcheck disable=SC1091
source ".env"

# shellcheck disable=SC2154
host="${GATEWAY_NAME}.localtest.me"
for provider_path in tags/*; do
    provider=$(basename "${provider_path}")
    echo "${provider} ${host}"

    scripts/tag-export.sh -d -p "${provider}" "${host}"
done
echo ""