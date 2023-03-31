#!/bin/bash

# Make a request to the colormind API
response=$(curl -s -X GET "http://colormind.io/api/" --data '{"model":"default"}')

# Extract the colors using 'jq'
colors=($(echo "$response" | jq -r '.result[] | join(",")' | awk -F, '{printf("#%02x%02x%02x\n", $1, $2, $3)}'))

# Assign labels to the colors
primary="${colors[0]}"
secondaryA="${colors[1]}"
secondaryB="${colors[2]}"
secondaryC="${colors[3]}"
secondaryD="${colors[4]}"

# Output the labeled colors
echo "Primary: $primary"
echo "Secondary A: $secondaryA"
echo "Secondary B: $secondaryB"
echo "Secondary C: $secondaryC"
echo "Secondary D: $secondaryD"

