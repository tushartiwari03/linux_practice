

#!/bin/bash


ALERT_EMAIL="USER"
LOGFILE="$HOME/linux_practice/logs/health.log"

echo "Cron ran at $(date)" >> ~/linux_practice/logs/cron_test.log

LOGFILE=~/linux_practice/logs/system_health.log

echo "==========================================================" | tee -a "$LOGFILE"
echo "       SYSTEM HEALTH REPORT" | tee -a "$LOGFILE"
echo "==========================================================" | tee -a "$LOGFILE"
echo "Date: $(date)" | tee -a "$LOGFILE"
echo "Hostname: $(hostname)" | tee -a "$LOGFILE"
echo "" | tee -a "$LOGFILE"

echo "--------CPU Load--------" | tee -a "$LOGFILE"
uptime | tee -a "$LOGFILE"
echo "" | tee -a "$LOGFILE"

echo "------Memory Usage------" | tee -a "$LOGFILE"
free -h | tee -a "$LOGFILE"
echo "" | tee -a "$LOGFILE"

# MEMORY THRESHOLD CHECK
MEM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", $3/$2 * 100}')

if [ "$MEM_USAGE" -gt 80 ]; then
    MESSAGE= "WARNING: High Memory Usage - ${MEM_USAGE}% on $(hostname)"
    echo "$MESSAGE"| tee -a $LOGFILE
    echo "$MESSAGE"| mail -s "Memory Alert" $ALERT_EMAIL
else
    echo "Memory OK - ${MEM_USAGE}%" | tee -a $LOGFILE
fi

echo "" | tee -a "$LOGFILE"

echo "-------Disk Usage-------" | tee -a "$LOGFILE"
df -h | tee -a "$LOGFILE"
echo "" | tee -a "$LOGFILE"

# DISK THRESHOLD CHECK
DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$DISK_USAGE" -gt 80 ]; then
    MESSAGE "WARNING: High Disk Usage - ${DISK_USAGE}% on $(hostname)"
    echo "$MESSAGE" | tee -a $LOGFILE
    echo "$MESSAGE" | mail -s "Disk Alert" $Alert_EMAIL
else
    echo "Disk usage is normal - ${DISK_USAGE}%" | tee -a "$LOGFILE"
fi

echo "" | tee -a "$LOGFILE"

echo "-----Top 5 Processes (Memory)------" | tee -a "$LOGFILE"
ps aux --sort=-%mem | head -6 | tee -a "$LOGFILE"

