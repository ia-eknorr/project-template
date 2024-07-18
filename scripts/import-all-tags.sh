#!/bin/bash

set -eo pipefail

# shellcheck disable=SC1091
source ".env"

scripts/tag-import.sh -c d -d tags -a --force --debug "${GATEWAY_NAME}.localtest.me"

echo ""