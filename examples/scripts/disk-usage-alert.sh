#!/usr/bin/env bash
set -euo pipefail

THRESHOLD="${1:-85}"
FAILED=0

while read -r filesystem size used avail capacity mountpoint; do
    usage="${capacity%\%}"
    if [[ "$usage" =~ ^[0-9]+$ ]] && (( usage >= THRESHOLD )); then
        echo "WARNING: $filesystem is ${usage}% full (mounted on $mountpoint)"
        FAILED=1
    fi
done < <(df -P -x tmpfs -x devtmpfs | tail -n +2)

if (( FAILED == 0 )); then
    echo "OK: all monitored filesystems are below ${THRESHOLD}%"
fi
exit "$FAILED"
