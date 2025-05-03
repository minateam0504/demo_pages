#!/bin/bash
# Script to update all HTML files to include the Mina logo
# Usage: ./update-logo.sh

echo "Updating HTML files to include Mina logo..."

# Add CSS link to HTML files
for file in *.html; do
    if grep -q "mina-logo.css" "$file"; then
        echo "✓ $file already has logo CSS"
    else
        echo "Adding logo CSS to $file"
        sed -i '' 's|<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">|<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">\n    <link rel="stylesheet" href="assets/mina-logo.css">|' "$file"
    fi
done

# Replace old logo placeholders with new logo
for file in *.html; do
    # Replace logo-text div
    if grep -q '<div class="logo-text">Mina</div>' "$file"; then
        echo "Replacing text logo in $file"
        sed -i '' 's|<div class="logo-text">Mina</div>|<div class="mina-header-logo"><svg class="mina-header-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M220 170C234.5 170 246 158.5 246 144C246 129.5 234.5 118 220 118C219.3 118 218.6 118 217.9 118.1C214.4 104.2 202 94 187 94C171.5 94 158.8 104.9 156 119.2C152.4 116.7 148.1 115.3 143.5 115.3C132.9 115.3 124.2 123.2 123 133.4C115.2 136.6 110 144.3 110 153C110 165.2 120.2 175 132.5 175" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/><circle cx="160" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><circle cx="220" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><path d="M235 210H240C242.8 210 245 207.8 245 205V195C245 192.2 242.8 190 240 190H235" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/><path d="M190 130V210" stroke="#4A4656" stroke-width="9"/><path d="M145 170H235" stroke="#4A4656" stroke-width="9"/><path d="M145 130C145 130 167 130 190 130C213 130 190 170 190 170H145V130Z" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><path d="M145 130H190L190 170" fill="#D9DFCC" stroke="#4A4656" stroke-width="9"/></svg><div class="mina-header-logo-text">mina</div></div>|' "$file"
    fi
    
    # Replace logo-container with logo M
    if grep -q '<div class="logo-container">' "$file"; then
        echo "Replacing container logo in $file"
        sed -i '' 's|<div class="logo-container">\s*<div class="logo">M</div>\s*</div>|<div class="mina-centered-logo"><svg class="mina-centered-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M220 170C234.5 170 246 158.5 246 144C246 129.5 234.5 118 220 118C219.3 118 218.6 118 217.9 118.1C214.4 104.2 202 94 187 94C171.5 94 158.8 104.9 156 119.2C152.4 116.7 148.1 115.3 143.5 115.3C132.9 115.3 124.2 123.2 123 133.4C115.2 136.6 110 144.3 110 153C110 165.2 120.2 175 132.5 175" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/><circle cx="160" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><circle cx="220" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><path d="M235 210H240C242.8 210 245 207.8 245 205V195C245 192.2 242.8 190 240 190H235" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/><path d="M190 130V210" stroke="#4A4656" stroke-width="9"/><path d="M145 170H235" stroke="#4A4656" stroke-width="9"/><path d="M145 130C145 130 167 130 190 130C213 130 190 170 190 170H145V130Z" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/><path d="M145 130H190L190 170" fill="#D9DFCC" stroke="#4A4656" stroke-width="9"/></svg><div class="mina-centered-logo-text">mina</div></div>|' "$file"
    fi
done

echo "Logo update complete!" 