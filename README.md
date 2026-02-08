# bash-cloud-monitor

## 📌 Overview
**bash-cloud-monitor** is a production-style Bash automation project that monitors system health and audits AWS resources.  
It is designed using real DevOps scripting best practices such as defensive error handling, external configuration, structured logging, and cron-safe execution.

The project focuses on **reliability and predictability**, not one-off scripting.

---

## 🎯 Objectives
- Demonstrate production-ready Bash scripting skills
- Automate system health checks using Linux utilities
- Audit AWS resources using the AWS CLI
- Follow DevOps best practices for safety, logging, and configuration
- Build cron-safe, non-interactive automation

---

## 🧠 Design Principles
This project is intentionally written with the following principles:

- **Fail fast** using `set -euo pipefail`
- **No hardcoded secrets** (external `.env` configuration)
- **Absolute paths** for cron compatibility
- **Structured logging** with timestamps
- **Modular functions** for readability and maintenance
- **Dependency validation** before execution

---

## 📁 Project Structure
bash-cloud-monitor/
├── monitor.sh # Main monitoring script
├── .env.example # Configuration template (no secrets)
├── logs/
│ └── monitor.log # Generated logs
└── README.md

---

## ⚙️ Prerequisites
The following tools must be installed and configured:

- Bash (Linux / WSL)
- AWS CLI (configured with valid credentials)
- `jq`
- `curl`

Verify dependencies:
```bash
aws --version
jq --version
curl --version

##🔧 Configuration
Create a configuration file from the template:
cp .env.example .env

##▶️ Usage

Make the script executable:

chmod +x monitor.sh


Run manually:

./monitor.sh


Logs will be written to:

logs/monitor.log

##⏰ Cron Integration (Optional)

This script is cron-safe and can be scheduled for periodic execution.

Example: run every 15 minutes
*/15 * * * * /home/username/bash-cloud-monitor/monitor.sh


Always use absolute paths in cron jobs.

##📊 Data Collected
System Health

CPU load

Memory usage

Disk usage

AWS Resources

EC2 instance IDs

IAM user list

All data is logged with timestamps for traceability.

##🔐 Security Considerations

No credentials stored in the script

Uses AWS CLI authentication (IAM user or role)

External configuration via .env

Designed to run with least-privilege permissions

##🚀 Future Improvements

Alerting (email / Slack)

Threshold-based warnings

CI pipeline with ShellCheck

Retry logic for AWS API calls

Dockerized execution

Infrastructure provisioning with Terraform

##🧠 Learning Outcomes

This project demonstrates:

Bash scripting fundamentals

Defensive scripting techniques

Command substitution

Linux system monitoring

AWS CLI automation

Cron-safe scripting

DevOps operational mindset
