# Docker Backup Script

## Overview
This script automates the backup process for running Docker containers by:
- Creating an image snapshot of each running container.
- Exporting each container's filesystem as a `.tar` archive.
- Maintaining up to 24 backups (older ones get deleted automatically).
- Logging backup operations with timestamps.
- Compressing logs if they exceed 40MB.

## Features
- **Automated Backup:** No manual intervention required.
- **Dual Backup System:** Both Docker images and `.tar` archives are created.
- **Log Rotation:** Ensures logs don’t consume excessive disk space.
- **Old Backup Cleanup:** Prevents excessive storage usage.
- **Hostname-based Backup Naming:** Ensures uniqueness in multi-host environments.

## Requirements
Ensure you have the following installed on your system:
- Docker
- Bash (for running the script)
- Sufficient disk space for backups

## Installation
Clone the repository and grant execution permissions:
```sh
git clone https://github.com/YOUR_GITHUB/docker-backup-script.git
cd docker-backup-script
chmod +x backup_script.sh
```

## Usage
Run the script manually:
```sh
./backup_script.sh
```

Or schedule it with `cron` to run automatically:
```sh
crontab -e
```
Add the following line to schedule a backup every 6 hours:
```sh
0 */6 * * * /path/to/backup_script.sh
```

## Example Output
```
[2025-03-29 17:05:53] Starting Docker backup...
[2025-03-29 17:05:55] Backing up container: nginx_exporter
Creating a new image from the running container: nginx_exporter...
sha256:65e6cc02d014872737f3ffe409f01b6f03dd8e01470967e3747265b0c0a4b9bf
[2025-03-29 17:05:55] Image created: bk_localhost.localdomain_nginx_exporter_2503291705
Exporting the container's filesystem to a tar archive...
[2025-03-29 17:05:55] Backup saved: /backup/docker/nginx_exporter_2503291705.tar
```

## Script Breakdown
### Backup Process
1. **Identifies Running Containers** – The script fetches the list of currently running containers.
2. **Creates Image Snapshots** – Each container is committed to a new Docker image.
3. **Exports Filesystem** – The entire container filesystem is saved as a `.tar` file.
4. **Removes Old Backups** – Ensures only the latest 24 backups are kept.
5. **Log Management** – If logs exceed 40MB, they are compressed and archived.

## Troubleshooting
### No space left on device
- Check available disk space: `df -h`
- Remove old backups manually: `rm -rf /backup/docker/*.tar`
- Increase storage capacity or change the backup directory.

### Permission denied
Ensure the script has execution permissions:
```sh
chmod +x backup_script.sh
```
Run it with sudo if needed:
```sh
sudo ./backup_script.sh
```

