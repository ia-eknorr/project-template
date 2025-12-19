#!/bin/bash
set -e

DATA_DIR="/data"

if [ ! -f "${DATA_DIR}/.ignition-seed-complete" ]; then
  echo "Seeding data for gateway..."

  # Copy base ignition data
  cp -dpR /usr/local/bin/ignition/data/* "${DATA_DIR}/"

  # Generate deterministic UUID and save to gateway network location
  UUID=$(echo -n "${GATEWAY_NAME}" | md5sum | awk '{print $1}' | sed 's/\(........\)\(....\)\(....\)\(....\)\(............\)/\1-\2-\3-\4-\5/' | tr -d '[:space:]')
  mkdir -p "${DATA_DIR}/config/local/ignition/gateway-network"
  echo -n "${UUID}" > "${DATA_DIR}/config/local/ignition/gateway-network/uuid.txt"
  echo "Generated UUID for gateway: ${UUID}"

  echo "{}" > "${DATA_DIR}/commissioning.json"
  touch "${DATA_DIR}/.ignition-seed-complete"

  echo "Seeding complete for gateway."
else
  echo "Gateway already seeded, skipping..."
fi

echo "Bootstrap completed successfully."