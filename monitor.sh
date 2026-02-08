#!/usr/bin/env bash
###############################################################################
# Author  : Chirag
# Version : 1.0.0
# Purpose : System + AWS Resource Monitoring (DevOps Bash Project)
###############################################################################

set -euo pipefail

# -------------------- GLOBALS --------------------
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
LOG_DIR="$SCRIPT_DIR/logs"
LOG_FILE="$LOG_DIR/monitor.log"
CONFIG_FILE="$SCRIPT_DIR/.env"

mkdir -p "$LOG_DIR"

# -------------------- LOGGING --------------------
log() {
  echo "[$(date '+%F %T')] $1" >> "$LOG_FILE"
}

# -------------------- VALIDATION --------------------
validate_config() {
  if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "❌ Config file missing: $CONFIG_FILE"
    exit 1
  fi

  # shellcheck disable=SC1090
  source "$CONFIG_FILE"

  : "${AWS_REGION:?AWS_REGION not set}"
}

validate_dependencies() {
  for cmd in aws jq curl; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
      log "❌ Missing dependency: $cmd"
      exit 1
    fi
  done
}

# -------------------- SYSTEM HEALTH --------------------
system_health() {
  log "===== SYSTEM HEALTH ====="

  CPU_LOAD=$(uptime | awk -F'load average:' '{print $2}')
  MEMORY=$(free -h | awk '/Mem:/ {print $3 "/" $2}')
  DISK=$(df -h / | awk 'NR==2 {print $5}')

  log "CPU Load   : $CPU_LOAD"
  log "Memory     : $MEMORY"
  log "Disk Usage : $DISK"
}

# -------------------- AWS CHECKS --------------------
aws_resources() {
  log "===== AWS RESOURCES ====="
  log "Region: $AWS_REGION"

  # EC2
  INSTANCES=$(aws ec2 describe-instances \
    --region "$AWS_REGION" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

  if [[ -z "$INSTANCES" ]]; then
    log "No EC2 instances found"
  else
    for id in $INSTANCES; do
      log "EC2 Instance: $id"
    done
  fi

  # IAM
  USERS=$(aws iam list-users \
    --query "Users[].UserName" \
    --output text)

  if [[ -z "$USERS" ]]; then
    log "No IAM users found"
  else
    for user in $USERS; do
      log "IAM User: $user"
    done
  fi
}

# -------------------- MAIN --------------------
main() {
  log "========== MONITORING STARTED =========="

  validate_config
  validate_dependencies
  system_health
  aws_resources

  log "========== MONITORING COMPLETED =========="
}

main

