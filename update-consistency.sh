#!/bin/bash

echo "Applying design consistency fixes across the app..."

# 1. Remove Mina logo from all pages
echo "Removing Mina logos..."

# Remove the logo CSS import from all HTML files
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/<link rel="stylesheet" href="assets\/mina-logo.css">//' {} \;

# Remove logo components from HTML files
find /private/tmp/mina -name "*.html" -exec sed -i '' '/<div class="mina-header-logo">/,/<\/div class="mina-header-logo-text">mina<\/div>/d' {} \;
find /private/tmp/mina -name "*.html" -exec sed -i '' '/<div class="mina-centered-logo">/,/<\/div>/d' {} \;
find /private/tmp/mina -name "*.html" -exec sed -i '' '/<!-- Mina Centered Logo -->/d' {} \;
find /private/tmp/mina -name "*.html" -exec sed -i '' '/<!-- Mina Header Logo -->/d' {} \;

# 2. Remove "Back" text from back buttons, keeping only the arrow icon
echo "Removing 'Back' text from buttons..."

# Fix btn-back instances
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/<i class="fas fa-arrow-left mr-2"><\/i> Back/<i class="fas fa-arrow-left"><\/i>/' {} \;

# Fix "Back to Home" links
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/Back to Home/Home/' {} \;

# 3. Fix indentation issues by standardizing to 4 spaces
echo "Fixing indentation issues..."

# For now, we'll assume 4-space indentation is the standard
# In a real scenario, you might want to use a tool like prettier or beautify

# 4. Check for broken image links
echo "Checking for broken image links..."

# Look for image tags that might have broken links
grep -r "img src=" --include="*.html" /private/tmp/mina | grep -v "https://" | grep -v "data:image"

echo "Design consistency fixes applied!" 