# Linux System Health Monitoring & Automation

A Linux-based system health monitoring project that automates CPU, memory, and disk usage checks using Bash scripting, cron scheduling, and log rotation.  
This project simulates real-world infrastructure monitoring and operational troubleshooting.

---

## 📌 Problem Statement

In production Linux environments, system resource issues such as high memory usage or disk exhaustion can cause service downtime if not monitored proactively.  
Manual checks are error-prone and do not scale.

This project addresses that problem by:
- Automating system health checks
- Scheduling periodic monitoring
- Generating structured logs
- Managing log growth safely

---

## 🧠 Architecture & Workflow

1. A Bash script (system_health.sh) collects system metrics:
   - CPU usage
   - Memory usage
   - Disk usage
2. Thresholds are evaluated during each run
3. Logs are written to a dedicated logs directory
4. The script is scheduled via cron to run automatically
5. logrotate manages log size and compression
