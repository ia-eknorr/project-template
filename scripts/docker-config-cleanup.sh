#!/bin/sh
set -e

echo 'Watching for config modifications...'
PATTERN="services/ignition/config/resources/*/ignition/*/resource.json"
RESTORED=false

while [ "$RESTORED" = "false" ]; do
  if git diff --quiet "$PATTERN" 2>/dev/null; then
    sleep 5
  else
    echo "Changes detected in config files! Restoring..."
    git restore "$PATTERN" 2>/dev/null
    echo "Configs restored! Monitoring for 40 more seconds to ensure stability..."
    RESTORED=true
  fi
done

# Monitor for 40 seconds after first restore to catch any late modifications
for _ in 1 2 3 4 5 6 7 8 9 10; do
  sleep 4
  if ! git diff --quiet "$PATTERN" 2>/dev/null; then
    echo "Additional changes detected, restoring again..."
    git restore "$PATTERN" 2>/dev/null
  fi
done

echo "Config cleanup complete, exiting."