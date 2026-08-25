#!/usr/bin/env bash
set -euo pipefail

THRESHOLD="${1:-85}"

df -P -x tmpfs -x devtmpfs | awk -v threshold="$THRESHOLD" '
NR > 1 {
    usage=$5
    gsub("%","",usage)
    if (usage >= threshold) {
        printf "WARNING: %s is %s%% full (mounted on %s)\n", $1, usage, $6
        found=1
    }
}
END {
    if (found) exit 1
}
'

if [[ $? -eq 0 ]]; then
    echo "OK: all monitored filesystems are below ${THRESHOLD}%"
fi
