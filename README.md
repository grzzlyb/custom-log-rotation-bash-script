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
