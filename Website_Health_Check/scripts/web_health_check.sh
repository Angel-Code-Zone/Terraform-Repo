#!/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

HTTP_CODE=$(curl \
    -s \
    -o /dev/null \
    -w "%{http_code}" \
    http://localhost:80/)

LOG_FILE="/var/log/website-health/website-health.log"

if [ "$HTTP_CODE" = "200" ]; then
    STATUS="UP"
else
    STATUS="DOWN"
fi

echo "$TIMESTAMP | Website=$STATUS | HTTP_CODE=$HTTP_CODE" >> "$LOG_FILE"

aws s3 cp \
    "$LOG_FILE" \
    "s3://${s3_bucket}/logs/website-health/website-health.log"