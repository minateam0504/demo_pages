#!/bin/bash

echo "=== APPLYING ALL DESIGN CONSISTENCY FIXES ==="
echo ""

# Make scripts executable
chmod +x /private/tmp/mina/update-consistency.sh
chmod +x /private/tmp/mina/fix-image-links.sh
chmod +x /private/tmp/mina/fix-indentation.sh

# 1. First, remove Mina logos and fix back buttons
echo "Step 1: Removing Mina logos and fixing back buttons..."
/private/tmp/mina/update-consistency.sh
echo ""

# 2. Fix broken image links
echo "Step 2: Fixing broken image links..."
/private/tmp/mina/fix-image-links.sh
echo ""

# 3. Fix indentation issues
echo "Step 3: Fixing indentation issues..."
/private/tmp/mina/fix-indentation.sh
echo ""

echo "All fixes have been applied successfully!"
echo ""
echo "Summary of changes:"
echo "1. Removed Mina logos from all pages"
echo "2. Removed 'Back' text from back buttons, keeping only the arrow icon"
echo "3. Changed 'Back to Home' to 'Home'"
echo "4. Fixed and standardized broken image links"
echo "5. Fixed indentation issues across HTML files"
echo "6. Standardized inline styles"
echo ""
echo "=== DESIGN CONSISTENCY FIXES COMPLETE ===" 