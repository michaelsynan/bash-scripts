#!/bin/bash

CONFIG_FILE="$HOME/.sendo_config"

# Function to change the destination file
change_dest_file() {
    read -p "Enter the new destination path and filename (including extension): " NEW_DEST_FILE
    echo "$NEW_DEST_FILE" > "$CONFIG_FILE"
    echo "Destination file changed to $NEW_DEST_FILE"
}

# Function to reset the destination file
reset_dest_file() {
    rm "$CONFIG_FILE"
    echo "Destination file reset. You will be prompted for a new destination file on the next run."
}

# Function to show the current destination file
show_dest_file() {
    echo "Current destination file: $DEST_FILE"
}

# Check if the config file exists and create it if it doesn't
if [ ! -f "$CONFIG_FILE" ]; then
    read -p "Enter the destination path and filename (including extension): " DEST_FILE
    echo "$DEST_FILE" > "$CONFIG_FILE"
else
    DEST_FILE=$(cat "$CONFIG_FILE")
fi

# Check if the first argument is a special option
case "$1" in
    --change-dest|-c)
        change_dest_file
        exit 0
        ;;
    --reset-dest|-r)
        reset_dest_file
        exit 0
        ;;
    --show-dest|-s)
        show_dest_file
        exit 0
        ;;
esac

# Get the command to be copied to the file
if [ -z "$1" ]; then
    if [ ! -t 0 ]; then
        # Read command from stdin (piped input)
        CMD=$(cat)
    else
        # Read command from user input
        read -p "Enter the command to be copied: " CMD
    fi
else
    CMD="$1"
fi

# Get the note, if provided
if [ -z "$2" ]; then
    read -p "Enter an optional note (leave empty if no note is needed): " NOTE
else
    NOTE="$2"
fi

# Get the current date
CURRENT_DATE=$(date "+%Y-%m-%d %H:%M")

# Append the command, note, and date to the end of the file
echo -e "\n### $CURRENT_DATE \n\`\`\`\n$CMD\n\`\`\`" >> "$DEST_FILE"

if [ ! -z "$NOTE" ]; then
    echo -e "\n **Note:** $NOTE" >> "$DEST_FILE"
fi

echo "Command appended to $DEST_FILE"

