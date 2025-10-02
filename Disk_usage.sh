#!/bin/bash

#---- Disk Usage Monitoring ---
DISK_THRESHOLD=90 #Disk space threshold in percentage
DISK_USAGE=$(df -h / | awk '$NF=="/"{print $5}' | sed 's/%//')

if (( DISK_USAGE > DISK_THRESHOLD )); then
	echo "Alert: Disk space usage on / is at ${DISK_USAGE}%!" | mail -s "Disk Space Alert" ashish.cloudpro@gmail.com
fi

#---- Log Parsing ---
LOG_FILE="/var/log/syslog" #Example log file
ERROR_PATTERNS=("error") #Add your error patterns

for pattern in "${ERROR_PATTERNS[@]}"; do
	grep -i "$pattern" "$LOG_FILE" | while IFS= read -r line; do
	echo "Log entry containing '$pattern': $line" | mail -s "Log File Alert" ashish.cloudpro@gmail.com
	done
done
echo "Disk usage and log parsing complete."
