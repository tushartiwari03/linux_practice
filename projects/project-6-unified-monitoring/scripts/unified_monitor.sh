#!/bin/bash


LOG_FILE=logs/unified_monitor.log
DATE=$(date)
ISSUES=0

echo "==== Unified Check : $DATE ====" >> $LOG_FILE

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU_USAGE%.*}

if [ $CPU_INT -gt 80 ]; then
  echo "CPU HIGH: ${CPU_INT}%" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "CPU OK: ${CPU_INT}%" >> $LOG_FILE
fi

MEM_USAGE=$(free | awk '/Mem/{printf("%.0f"), $3/$2 * 100}')

if [ $MEM_USAGE -gt 80 ]; then
  echo "MEMORY HIGH: ${MEM_USAGE}%" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "MEMORY OK: ${MEM_USAGE}%" >> $LOG_FILE
fi

DISK_USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ $DISK_USAGE -gt 80 ]; then
  echo "DISK HIGH: ${DISK_USAGE}%" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "DISK OK: ${DISK_USAGE}%" >> $LOG_FILE
fi


ping -c 2 google.com > /dev/null

if [ $? -ne 0 ]; then
  echo "NETWORK DOWN" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "NETWORK OK" >> $LOG_FILE
fi


ERROR_COUNT=$(grep -i "error\|failed\|critical" /var/log/syslog | wc -l)

if [ $ERROR_COUNT -gt 50 ]; then
  echo "LOG ANOMALY DETECTED: ${ERROR_COUNT} errors" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "LOGS OK: ${ERROR_COUNT} errors" >> $LOG_FILE
fi

ERROR_COUNT=$(grep -i "error\|failed\|critical" /var/log/syslog | wc -l)

if [ $ERROR_COUNT -gt 50 ]; then
  echo "LOG ANOMALY DETECTED: ${ERROR_COUNT} errors" >> $LOG_FILE
  ISSUES=$((ISSUES+1))
else
  echo "LOGS OK: ${ERROR_COUNT} errors" >> $LOG_FILE
fi


if [ $ISSUES -eq 0 ]; then
  echo "SYSTEM HEALTH: OK" >> $LOG_FILE

elif [ $ISSUES -eq 1 ]; then
  echo "SYSTEM HEALTH: WARNING" >> $LOG_FILE
  echo "Warning: One issue detected on system" | mail -s "AIOps Warning Alert" $USER

else
  echo "SYSTEM HEALTH: CRITICAL" >> $LOG_FILE
  echo "CRITICAL: Multiple issues detected on system" | mail -s "AIOps CRITICAL Alert" $USER
fi
