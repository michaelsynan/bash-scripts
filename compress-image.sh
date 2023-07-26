#!/bin/bash

# Ensure a file name is provided
if [ -z "$1" ]
then
    echo "No filename provided. Usage: $0 filename"
    exit 1
fi

# Ensure the file exists
if [ ! -f "$1" ]
then
    echo "File $1 not found."
    exit 1
fi

# Extract the base filename without extension
base_filename=$(basename "$1" .jpg)

# Reduce, compress, and convert the image
convert "$1" -resize 50% "${base_filename}_resized.jpg"
convert "${base_filename}_resized.jpg" -strip -quality 85% "${base_filename}_compressed.jpg"
cwebp -q 80 "${base_filename}_compressed.jpg" -o "${base_filename}.webp"

echo "Processing complete. Output: ${base_filename}.webp"
