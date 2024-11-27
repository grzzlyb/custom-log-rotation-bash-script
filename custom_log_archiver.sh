#!/bin/bash

# Directory containing the log files
LOG_DIR="/var/log/mongodb"

# Change to the log directory
cd "$LOG_DIR" || { echo "Failed to change directory to $LOG_DIR"; exit 1; }

# Create a temporary directory for the archive
TEMP_DIR="artefacts"
mkdir -p "$TEMP_DIR"

# Get the current timestamp
TIMESTAMP=$(date +"%Y%m%d%H%M%S")

# Pre-create the archive file
ARCHIVE="$TEMP_DIR/logs_$TIMESTAMP.tar.gz"
touch "$ARCHIVE"

# Create a function to handle tar errors
handle_tar_error() {
    local file="$1"
    local error_message="$2"
    echo "Error: $error_message"
    echo "Skipping file: $file"
}

# Create a tarball of all .log files with maximum compression (-9), excluding the archive file itself
# Ignore errors due to files changing during compression
tar --use-compress-program="gzip -9" --exclude="$ARCHIVE" -cf "$ARCHIVE" *.log 2>&1 | \
while IFS= read -r line; do
    if [[ "$line" == *"file changed as we read it"* ]]; then
        file=$(echo "$line" | awk '{print $NF}')
        handle_tar_error "$file" "$line"
    fi
done

# Check if the tar command was successful
if [ $? -eq 0 ]; then
    echo "Compression successful, truncating log files..."
    # Truncate all .log files
    for log_file in *.log; do
        > "$log_file"
        if [ $? -eq 0 ]; then
            echo "Truncated $log_file"
        else
            echo "Failed to truncate $log_file"
        fi
    done
    echo "Log files compressed and truncated successfully."

    # Delete .gz files older than 14 days
    find "$TEMP_DIR" -name "*.tar.gz" -mtime +14 -exec rm {} \;
    echo "Deleted .tar.gz files older than 14 days."
else
    echo "Failed to compress log files."
    exit 1
fi
