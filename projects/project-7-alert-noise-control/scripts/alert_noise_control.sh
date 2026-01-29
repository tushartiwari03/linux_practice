#!/bin/bash

LOG_FILE="$(pwd)/logs/alert.log"
STATE_FILE="$(pwd)/state/alert_state.txt"
THRESHOLD=3
COOLDOWN=600   # 10 minutes

CPU_LIMIT=80
CURRENT_CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')

TIMESTAMP=$(date +%s)

mkdir -p logs state
touch "$LOG_FILE" "$STATE_FILE"

LAST_ALERT_TIME=$(cat "$STATE_FILE" 2>/dev/null)

if (( ${CURRENT_CPU%.*} > CPU_LIMIT )); then
    COUNT=$(grep -c "CPU_HIGH" "$LOG_FILE")
    
    if [[ -z "$LAST_ALERT_TIME" ]] || (( TIMESTAMP - LAST_ALERT_TIME > COOLDOWN )); then
        echo "CPU_HIGH detected at $(date)" >> "$LOG_FILE"
        
        if (( COUNT >= THRESHOLD )); then
            echo "CRITICAL: CPU High $COUNT times" | mail -s "CRITICAL CPU ALERT" $USER
            echo "$TIMESTAMP" > "$STATE_FILE"
        fi
    fi
else
    echo "CPU normal at $(date)" >> "$LOG_FILE"
fi
