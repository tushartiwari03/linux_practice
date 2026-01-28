#!/bin/bash

LOG_FILE=logs/network_health.log
DATE=$(date)

echo "==== Network Health Check : $DATE ====" >> $LOG_FILE

# Ping check
ping -c 2 google.com > /dev/null
if [ $? -ne 0 ]; then
  echo "Ping FAILED at $DATE" >> $LOG_FILE
  echo "Network Ping Failure" | mail -s "Network Alert" $USER
else
  echo "Ping OK" >> $LOG_FILE
fi

# Port check
nc -z google.com 443
if [ $? -ne 0 ]; then
  echo "Port 443 DOWN" >> $LOG_FILE
  echo "Port 443 Down" | mail -s "Network Alert" $USER
else
  echo "Port 443 OK" >> $LOG_FILE
fi

# Service check
systemctl is-active sshd > /dev/null
if [ $? -ne 0 ]; then
  echo "SSHD Service DOWN" >> $LOG_FILE
  echo "SSHD Service Down" | mail -s "Service Alert" $USER
else
  echo "SSHD Service OK" >> $LOG_FILE
fi
