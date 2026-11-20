#!/usr/bin/bash
# platform = multi_platform_all
# check-import = stdout

THRESHOLD="5.0"

if ! command -v systemd-analyze >/dev/null 2>&1; then
    echo "systemd-analyze not found"
    exit "$XCCDF_RESULT_NOT_APPLICABLE"
fi

if ! systemctl cat sshd.service >/dev/null 2>&1; then
    echo "sshd.service is not installed"
    exit "$XCCDF_RESULT_NOT_APPLICABLE"
fi

SCORE=$(systemd-analyze security --no-pager sshd.service 2>/dev/null \
    | grep 'Overall exposure level' \
    | sed -E 's/.*: ([0-9]+(\.[0-9]+)?) .*/\1/')

if [ -z "$SCORE" ]; then
    echo "Could not read exposure level for sshd.service"
    exit "$XCCDF_RESULT_ERROR"
fi

echo "sshd.service exposure level: $SCORE (threshold: $THRESHOLD)"

if awk -v s="$SCORE" -v t="$THRESHOLD" 'BEGIN { exit !(s <= t) }'; then
    exit "$XCCDF_RESULT_PASS"
fi
exit "$XCCDF_RESULT_FAIL"
