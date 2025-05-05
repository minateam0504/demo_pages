#!/bin/bash

echo "Replacing robot icons with M icons across all screens..."

# Find all files with the robot icon and replace with the M icon
# First handle the case where it's inside .mina-assistant-button (for newer pages like car-seats-listing.html)
find /private/tmp/mina -type f -name "*.html" -exec sed -i '' 's/<i class="fas fa-robot"><\/i>/<span style="font-weight: bold; font-size: 20px;">M<\/span>/g' {} \;

# Handle the case where it's inside the ai-avatar (for older pages like seller-step2.html)
find /private/tmp/mina -type f -name "*.html" -exec sed -i '' 's/<div class="ai-avatar">\s*<i class="fas fa-robot"><\/i>/<div class="ai-avatar">\n                <span style="font-weight: bold; font-size: 20px;">M<\/span>/g' {} \;

# Add more patterns for other variations if needed

echo "Icon replacement complete!" 