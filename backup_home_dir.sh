#!/usr/bin/env bash

start_time=$(date +%s)  # Capture start time in seconds since the epoch

# Configuration
backup_root=$HOME
backup_dest="$backup_root/backups/data" # Set your backup destination path
config_file="$backup_root/backups/backup_exclude.conf"
backup_log="$backup_root/backups/logs/$(date +%Y%m%d)_backup.log"
timestamp=$(date +%Y%m%d)
backup_filename="${backup_dest}/${timestamp}_home_backup.tar.gz"

# Ensure the configuration file exists
if [[ ! -f "$config_file" ]]; then
    echo "Configuration file not found: $config_file"
    exit 1
fi

# Ensure the backup log can be created or appended to
touch "$backup_log" || { echo "Cannot write to log file: $backup_log"; exit 1; }

# Log start
echo "Backup started at $(date)" | tee -a "$backup_log"

# Create the backup
tar --exclude-from="$config_file" -zcvf "$backup_filename" "$backup_root" >> "$backup_log" 2>&1

# Verify the backup
if ! tar -tzf "$backup_filename" > /dev/null; then
    echo "Backup verification failed." | tee -a "$backup_log"
    exit 1
else
    echo "Backup verified successfully." | tee -a "$backup_log"
fi


end_time=$(date +%s)  # Capture end time
duration=$((end_time - start_time))  # Calculate the difference in seconds
minutes=$((duration / 60))

# Finish
echo "Backup completed at $(date) (took $minutes minutes)" | tee -a "$backup_log"
