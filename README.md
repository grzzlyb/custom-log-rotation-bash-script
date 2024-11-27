# Custom Log Archiver Script

This Bash script helps manage log files by compressing, truncating, and cleaning them efficiently.

## Features

- Compresses `.log` files in the log directory into timestamped archives.
- Truncates logs after successful compression.
- Deletes archives older than 14 days.

## Requirements

- **Bash shell** (tested on Linux)
- **tar** and **gzip** utilities.

## Setup

1. **Download the script**: Save this script on your server.
2. **Update the directory**: Set `LOG_DIR` to your log directory:
   ```bash
   LOG_DIR="/your/log/directory"
3. **Make the script executable**: After saving the script, make it executable by running:
```bash
chmod +x custom_log_archiver.sh

## Usage

### Manual Execution

Run the script manually by executing:
```bash
./custom_log_archiver.sh

### Automate with Cron

To automate the script (e.g., run it daily at midnight):

1. Open the crontab editor:
```bash
crontab -e

2. Add the following line to schedule the script:
```bash
0 0 * * * /path/to/custom_log_archiver.sh

## How It Works

1. **Compression**: Archives `.log` files into a timestamped `.tar.gz` archive stored in a subdirectory called `artefacts`.
2. **Truncation**: Clears the content of `.log` files after successful compression to free up disk space.
3. **Cleanup**: Deletes `.tar.gz` files in the `artefacts` directory that are older than 14 days.

