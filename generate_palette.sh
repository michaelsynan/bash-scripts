#!/bin/bash

# Make a request to the colormind API
response=$(curl -s -X GET "http://colormind.io/api/" --data '{"model":"default"}')

# Extract the colors using 'jq'
colors=($(echo "$response" | jq -r '.result[] | join(",")' | awk -F, '{printf("%d,%d,%d\n", $1, $2, $3)}'))

# Define a restricted range for the dark color
dark_min=(30 30 30)
dark_max=(100 100 100)

# Define a restricted range for the light color
light_min=(200 200 200)
light_max=(255 255 255)

# Iterate through the colors and assign labels to them
for i in "${!colors[@]}"; do
    color="${colors[$i]}"
    r=$(echo "$color" | cut -d',' -f1)
    g=$(echo "$color" | cut -d',' -f2)
    b=$(echo "$color" | cut -d',' -f3)

    # Check if the color is the "dark" or "light" color and restrict the range
    if [ "$i" -eq 3 ]; then
        r=$(echo "$r" | awk -v min="${dark_min[0]}" -v max="${dark_max[0]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        g=$(echo "$g" | awk -v min="${dark_min[1]}" -v max="${dark_max[1]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        b=$(echo "$b" | awk -v min="${dark_min[2]}" -v max="${dark_max[2]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        colors[$i]=$(printf "#%02x%02x%02x" "$r" "$g" "$b")
    elif [ "$i" -eq 4 ]; then
        r=$(echo "$r" | awk -v min="${light_min[0]}" -v max="${light_max[0]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        g=$(echo "$g" | awk -v min="${light_min[1]}" -v max="${light_max[1]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        b=$(echo "$b" | awk -v min="${light_min[2]}" -v max="${light_max[2]}" '{if ($1 < min) {print min} else if ($1 > max) {print max} else {print $1}}')
        colors[$i]=$(printf "#%02x%02x%02x" "$r" "$g" "$b")
    else
        colors[$i]=$(printf "#%02x%02x%02x" "$r" "$g" "$b")
    fi
done

# Assign labels to the colors
primary="${colors[0]}"
secondary="${colors[1]}"
tertiary="${colors[2]}"
dark="${colors[3]}"
light="${colors[4]}"

# Output the labeled colors
echo "Primary: $primary"
echo "Secondary: $secondary"
echo "Tertiary: $tertiary"
echo "Dark: $dark"
echo "Light: $light"
