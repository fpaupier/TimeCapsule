#!/usr/bin/env bash

# Exit on error, uninitialized variable use, and prevent pipeline error masking
set -euo pipefail

# Configuration
backup_root="$HOME"
backup_dest="$backup_root/backups/data"
config_file="$backup_root/backups/backup_exclude.conf"
backup_log="$backup_root/backups/logs/$(date +%Y%m%d)_backup.log"
timestamp=$(date +%Y%m%d)
backup_filename="${backup_dest}/${timestamp}_home_backup.tar.gz"

# Function to log messages
log_message() {
    echo "$1" | tee -a "$backup_log"
}

# Function to check if configuration file exists
check_config_file() {
    if [[ ! -f "$config_file" ]]; then
        log_message "Configuration file not found: $config_file"
        exit 1
    fi
}

# Function to create backup
create_backup() {
    tar --exclude-from="$config_file" -zcvf "$backup_filename" "$backup_root" >> "$backup_log" 2>&1
}

# Function to verify backup
verify_backup() {
    if ! tar -tzf "$backup_filename" > /dev/null; then
        log_message "Backup verification failed."
        exit 1
    else
        log_message "Backup verified successfully."
    fi
}

# Function to calculate and log the duration of the backup process
log_duration() {
    # shellcheck disable=SC2155
    local end_time=$(date +%s)
    local duration=$((end_time - start_time))
    local minutes=$((duration / 60))
    local hours=$((minutes / 60))
    log_message "Backup completed at $(date) (took $minutes minutes / ${hours} hours)"
}

# Main script execution
start_time=$(date +%s)  # Capture start time

# Ensure the backup log can be created or appended to
touch "$backup_log" || {
    log_message "Cannot write to log file: $backup_log"
    exit 1
}

log_message "Backup started at $(date)"

check_config_file
create_backup
verify_backup
log_duration
