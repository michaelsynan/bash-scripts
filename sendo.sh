#!/bin/bash

# Get the destination path and filename
if [ -z "$1" ]; then
    read -p "Enter the destination path and filename (including extension): " DEST_FILE
else
    DEST_FILE="$1"
fi

# Get the command to be copied to the file
if [ -z "$2" ]; then
    read -p "Enter the command to be copied: " CMD
else
    CMD="$2"
fi

# Append the command to the end of the file
echo -e "\n## Command\n\`\`\`\n$CMD\n\`\`\`" >> "$DEST_FILE"
echo "Command appended to $DEST_FILE"

