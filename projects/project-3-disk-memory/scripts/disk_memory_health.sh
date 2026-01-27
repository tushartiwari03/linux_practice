#!/bin/bash

LOG_DIR="$HOME/linux_practice/projects/project-3-disk-memory/logs"
STATE_FILE="$LOG_DIR/previous_state.txt"
LOG_FILE="$LOG_DIR/disk_memory.log"

mkdir -p "$LOG_DIR"

DATE=$(date "+%Y-%m-%d %H:%M:%S")

# Disk usage (root filesystem)
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Memory usage
MEM_TOTAL=$(free -m | awk '/Mem:/ {print $2}')
MEM_USED=$(free -m | awk '/Mem:/ {print $3}')
MEM_USAGE=$(( MEM_USED * 100 / MEM_TOTAL ))

# Load previous state
if [ -f "$STATE_FILE" ]; then
  PREV_DISK=$(awk '{print $1}' "$STATE_FILE")
  PREV_MEM=$(awk '{print $2}' "$STATE_FILE")
else
  PREV_DISK=0
  PREV_MEM=0
fi

DISK_DIFF=$(( DISK_USAGE - PREV_DISK ))
MEM_DIFF=$(( MEM_USAGE - PREV_MEM ))

# Save current state
echo "$DISK_USAGE $MEM_USAGE" > "$STATE_FILE"

# Log
echo "$DATE | Disk: ${DISK_USAGE}% (+${DISK_DIFF}%) | Memory: ${MEM_USAGE}% (+${MEM_DIFF}%)" >> "$LOG_FILE"

# Alert conditions
if [ "$DISK_USAGE" -ge 80 ] || [ "$DISK_DIFF" -ge 5 ] || \
   [ "$MEM_USAGE" -ge 75 ] || [ "$MEM_DIFF" -ge 10 ]; then
    echo "ALERT: Disk or Memory anomaly detected on $(hostname)" \
    | mail -s "Disk/Memory Anomaly Alert" "$USER"
fi
