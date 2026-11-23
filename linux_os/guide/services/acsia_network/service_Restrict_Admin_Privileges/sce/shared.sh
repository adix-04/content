#!/usr/bin/bash
# platform = multi_platform_all
# check-import = stdout

UID0_ACCOUNTS=$(awk -F: '($3 == 0) { print $1 }' /etc/passwd)

COUNT=$(echo "$UID0_ACCOUNTS" | wc -l)

echo "UID 0 accounts found:"
echo "$UID0_ACCOUNTS"

if [ "$COUNT" -eq 1 ] && [ "$UID0_ACCOUNTS" = "root" ]; then
    exit "$XCCDF_RESULT_PASS"
fi

exit "$XCCDF_RESULT_FAIL"