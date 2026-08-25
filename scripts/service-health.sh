#!/usr/bin/env bash
set -euo pipefail

SERVICES=("$@")

if [[ ${#SERVICES[@]} -eq 0 ]]; then
    SERVICES=(nginx prometheus node_exporter)
fi

FAILED=0

for service in "${SERVICES[@]}"; do
    if systemctl is-active --quiet "$service"; then
        echo "OK: $service"
    else
        echo "FAILED: $service"
        FAILED=1
    fi
done

exit "$FAILED"
