# 📊 Project 4: Log Anomaly Detection (AIOps Basics)

## 📌 Overview
In real production systems, applications generate large log files.  
Sudden spikes in error logs often indicate incidents, outages, or abnormal behavior.

This project simulates a *basic AIOps log anomaly detection system* using *Linux Bash scripting*.  
It continuously monitors application logs, detects sudden increases in error patterns, and sends *email alerts* when anomalies occur.

---

## 🎯 Objectives
- Understand how log monitoring works in real systems
- Detect abnormal spikes in error logs
- Automate monitoring using cron jobs
- Generate alerts for proactive incident response

---

## 🛠 Technologies Used
- Linux (Ubuntu)
- Bash Scripting
- Cron Jobs
- Mail utility (alerting)
- Git & GitHub

---

## 📂 Project Structure

project-4-log-anomaly/
├── scripts/
│ └── log_anomaly_detector.sh
├── logs/
│ └── log_anomaly.log
├── sample_logs/
│ └── app.log
├── state/
│ └── prev_count.txt
├── screenshots/
│ ├── script_run.png
│ ├── alert_mail.png
│ └── cron_job.png
└── README.md

---

## ⚙️ How the Script Works
1. Reads application logs (app.log)
2. Searches for error keywords:
   - ERROR
   - FAILED
   - TIMEOUT
3. Counts total error occurrences
4. Compares current count with previous run
5. Detects sudden spikes (anomalies)
6. Logs the result
7. Sends an email alert if anomaly threshold is exceeded

---

## ▶️ How to Run the Project

### 1️⃣ Clone the repository

```bash
git clone https://github.com/tushartiwari03/linux_practice.git
cd linux_practice/projects/project-4-log-anomaly


## Make the scriot executable
chmod +x scripts/log_anomaly_detector.sh


##Run it manually
./scripts/log_anomaly_detector.sh


##To automate it with cron
crontab -e
*/5 * * * * /full/path/to/log_anomaly_detector.sh

##Screenshots
Screenshots are added to demostarte:
1. Script Execution
2. Log generation
3. Email alert received
4. Cron job configuration
