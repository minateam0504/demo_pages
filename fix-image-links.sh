#!/bin/bash

echo "Fixing broken image links..."

# 1. Check for local image references that might be broken
echo "Identifying potentially broken image links..."

# Find all img tags with local sources (not https, http, or data)
find /private/tmp/mina -name "*.html" -exec grep -l "img src=\"[^(https|http|data)]" {} \; > /tmp/files_with_local_images.txt

# 2. Apply fixes for known broken images
echo "Applying fixes for known broken image patterns..."

# Replace broken logo.png references with appropriate placeholder
find /private/tmp/mina -name "*.html" -exec sed -i '' 's|src="logo.png"|src="assets/placeholder-logo.png"|g' {} \;

# Fix broken references to website favicons with direct CDN links
sed -i '' 's|src="https://www.babylist.com/favicon.ico"|src="https://cdn.shopify.com/s/files/1/0194/4850/1411/files/favicon_32x32.png"|g' /private/tmp/mina/buyer-product.html
sed -i '' 's|src="https://www.google.com/favicon.ico"|src="https://www.google.com/favicon.ico"|g' /private/tmp/mina/buyer-product.html

# 3. Normalize image paths
echo "Normalizing image paths..."

# Ensure all image paths in assets folder use the correct path format
find /private/tmp/mina -name "*.html" -exec sed -i '' 's|src="images/|src="assets/images/|g' {} \;

# Create assets directory if it doesn't exist
mkdir -p /private/tmp/mina/assets/images

# Create a placeholder image in case we need it
echo "Creating placeholder image..."
cat > /private/tmp/mina/assets/placeholder-logo.png << EOF
 