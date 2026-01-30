import os
import time
import json

CPU_THRESHOLD = 1.5
LOG_FILE = "logs/system.log"
issue_count=0

cpu_load = os.getloadavg()[0]

timestamp = time.strftime("%Y-%m-%d %H:%M:%S")

if cpu_load > CPU_THRESHOLD:
    message = f"{timestamp} | WARNING | High CPU Load: {cpu_load}"
    issue_count += 1
else:
    message = f"{timestamp} | OK | CPU Load: {cpu_load}"

print(message)

with open(LOG_FILE, "a") as log:
    log.write(message + "\n")

import psutil
memory = psutil.virtual_memory()
memory_usage = memory.percent

MEMORY_THRESHOLD = 80
if memory_usage > MEMORY_THRESHOLD:
    issue_count += 1
    message = f"{timestamp} | WARNING | High Memory Usage: {memory_usage}%"
    print(message)
    with open(LOG_FILE, "a") as log:
        log.write(message + "\n")

disk = psutil.disk_usage('/')
disk_usage = disk.percent

DISK_THRESHOLD = 80

if disk_usage > DISK_THRESHOLD:
    message = f"{timestamp} | WARNING | High Disk Usage: {disk_usage}%"
    issue_count += 1
    print(message)
    with open(LOG_FILE, "a") as log:
        log.write(message + "\n")
if issue_count == 0:
    severity = "OK"
elif issue_count == 1:
    severity = "INFO"
elif issue_count == 2:
    severity = "WARNING"
else:
    severity = "CRITICAL"

log_entry = {
    "timestamp": timestamp,
    "cpu_load": cpu_load,
    "memory_usage": memory_usage,
    "disk_usage": disk_usage,
    "issues_detected": issue_count,
    "severity": severity
}

print(log_entry)

with open(LOG_FILE, "a") as log:
    log.write(json.dumps(log_entry) + "\n")
import os

if severity == "CRITICAL":
    os.system(
        f'echo "Critical system issue detected. Details: {log_entry}" | '
        f'mail -s "CRITICAL SYSTEM ALERT" {os.getenv("USER")}'
    )
