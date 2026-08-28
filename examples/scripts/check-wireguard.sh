#!/usr/bin/env bash
set -euo pipefail

INTERFACE="${1:-wg0}"
MAX_AGE="${2:-300}"

if ! command -v wg >/dev/null 2>&1; then
    echo "CRITICAL: wg command not found"
    exit 2
fi

if ! ip link show "$INTERFACE" >/dev/null 2>&1; then
    echo "CRITICAL: interface $INTERFACE does not exist"
    exit 2
fi

HANDSHAKE="$(wg show "$INTERFACE" latest-handshakes | awk '{print $2}' | sort -nr | head -1)"

if [[ -z "${HANDSHAKE:-}" || "$HANDSHAKE" -eq 0 ]]; then
    echo "WARNING: no handshake recorded on $INTERFACE"
    exit 1
fi

NOW="$(date +%s)"
AGE=$((NOW - HANDSHAKE))

if (( AGE > MAX_AGE )); then
    echo "WARNING: latest handshake on $INTERFACE is ${AGE}s old"
    exit 1
fi

echo "OK: $INTERFACE latest handshake is ${AGE}s old"
