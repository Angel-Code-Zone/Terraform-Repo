#!/bin/bash

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOSTNAME=$(hostname)

CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {
    printf "%.2f", 100 - $8
}')

MEMORY_USAGE=$(free | awk '/Mem:/ {
    printf "%.2f", ($3/$2)*100
}')

DISK_USAGE=$(df -P / | awk 'NR==2 {
    print $5
}')

LOAD_AVERAGE=$(awk '{print $1}' /proc/loadavg)

LOG_FILE="/var/log/server-health/server-health.log"

echo "$TIMESTAMP | Host=$HOSTNAME | CPU=${CPU_USAGE}% | Memory=${MEMORY_USAGE}% | Disk=${DISK_USAGE} | Load=${LOAD_AVERAGE}" >> "$LOG_FILE"

aws s3 cp \
    "$LOG_FILE" \
    "s3://${s3_bucket}/logs/server-health/server-health.log"