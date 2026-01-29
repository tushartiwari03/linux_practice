# 🤖 Project 6: Unified AIOps Monitoring & Correlation Engine

## 📌 Overview
This project implements a unified monitoring system that correlates system, network, and log anomalies into a single intelligent alert.

Instead of sending multiple alerts, the system analyzes overall health and generates severity-based notifications.

---

## 🎯 Features
- CPU, Memory, Disk monitoring
- Network availability checks
- Log anomaly detection
- Issue correlation logic
- Severity-based alerting
- Automated execution using cron

---

## 🛠 Technologies Used
- Linux (Ubuntu)
- Bash Scripting
- Cron Jobs
- Mail Utility
- Git & GitHub

---

## 📂 Project Structure
project-6-unified-monitoring/
├── scripts/
├── logs/
├── state/
├── screenshots/
└── README.md

---

## ⚙️ How It Works
- Each health check increments an issue counter
- System health is classified as:
  - OK
  - WARNING
  - CRITICAL
- Only one consolidated alert is sent

---

## 🚀 Why This Matters for AIOps
This project demonstrates the core AIOps principle of *event correlation*, reducing alert noise and enabling proactive incident management.

---

## 👨‍💻 Author
Tushar Kumar Tiwari
Aspiring AIOps Engineer
