#!/bin/bash

clear
echo """
#################################################################################
##         Welcome To Docker Backup Script                                     ##
##         Date            `date "+%F %T "`                                    ##
##         Version         DockerBackup.V1.0.0                                 ##
##         Author          Nahid Asgari                                        ##
##         Copyright       Copyright (c) 2024 https://github.com/Nahidasgari71 ##
#################################################################################
"""

BACKUP_DIR="/backup/docker"
LOG_FILE="/var/log/docker_backup.log"
MAX_BACKUPS=24
LOG_MAX_SIZE=$((40 * 1024 * 1024))  # 40MB

mkdir -p "$BACKUP_DIR"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Docker backup..." | tee -a "$LOG_FILE"

containers=$(docker ps --format "{{.Names}}")

for container in $containers; do
    sleep $((RANDOM % 3 + 1))
    timestamp=$(date '+%y%m%d%H%M')
    image_name="bk_$(hostname)_${container}_$timestamp"
    backup_tar="$BACKUP_DIR/${container}_$timestamp.tar"

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backing up container: $container" | tee -a "$LOG_FILE"
    echo "Creating a new image from the running container: $container..." | tee -a "$LOG_FILE"
    

    image_id=$(docker commit "$container" "$image_name") && \
    echo "$image_id" | tee -a "$LOG_FILE"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Image created: $image_name" | tee -a "$LOG_FILE"
    
    echo "Exporting the container's filesystem to a tar archive..." | tee -a "$LOG_FILE"
    
docker export "$container" -o "$backup_tar" && \
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup saved: $backup_tar" | tee -a "$LOG_FILE"

done

echo "Removing old backups, keeping only the last $MAX_BACKUPS..." | tee -a "$LOG_FILE"
find "$BACKUP_DIR" -type f -name "*.tar" -printf '%T@ %p\n' | sort -n | head -n -$MAX_BACKUPS | awk '{print $2}' | xargs rm -f

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Cleanup completed." | tee -a "$LOG_FILE"

echo "Checking log file size..." | tee -a "$LOG_FILE"
if [ -f "$LOG_FILE" ] && [ $(stat -c%s "$LOG_FILE") -ge $LOG_MAX_SIZE ]; then
    echo "Log file exceeds $LOG_MAX_SIZE bytes, compressing..." | tee -a "$LOG_FILE"
    gzip "$LOG_FILE"
    mv "$LOG_FILE.gz" "$LOG_FILE-$(date '+%Y%m%d%H%M%S').gz"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Log archived." | tee "$LOG_FILE"
fi

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Backup process completed." | tee -a "$LOG_FILE"
