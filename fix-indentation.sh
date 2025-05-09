#!/bin/bash

echo "Fixing indentation issues..."

# Fix indentation in HTML files
echo "Standardizing indentation in HTML files..."

# For HTML files, we'll use a more basic approach since we can't use prettier directly in this shell script
# This will ensure at least consistent indenting in key areas

# Fix indentation in HTML files - focusing on common issues
for file in $(find /private/tmp/mina -name "*.html"); do
  echo "Processing $file..."
  
  # Fix inconsistent indentation after opening tags
  sed -i '' 's/<div>\s*</<div>\n    </g' "$file"
  sed -i '' 's/<section>\s*</<section>\n    </g' "$file"
  sed -i '' 's/<main>\s*</<main>\n    </g' "$file"
  
  # Fix inconsistent indentation in lists
  sed -i '' 's/<ul>\s*</<ul>\n    </g' "$file"
  sed -i '' 's/<ol>\s*</<ol>\n    </g' "$file"
  
  # Fix inconsistent indentation in tables
  sed -i '' 's/<table>\s*</<table>\n    </g' "$file"
  sed -i '' 's/<tr>\s*</<tr>\n    </g' "$file"
  
  # Fix inconsistent indentation in forms
  sed -i '' 's/<form>\s*</<form>\n    </g' "$file"
  
  # Add proper indentation for nested elements
  sed -i '' 's/<\/div><div>/<\/div>\n<div>/g' "$file"
  sed -i '' 's/<\/section><section>/<\/section>\n<section>/g' "$file"
done

# Style cleanup
echo "Cleaning up inline styles for consistency..."

# Fix style attribute issues
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/style=" /style="/g' {} \;
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/; "/;"/g' {} \;

# Add missing semi-colons to style properties
find /private/tmp/mina -name "*.html" -exec sed -i '' 's/([a-z-]+): ([^;"]*)"/\1: \2;"/g' {} \;

echo "Indentation fixes applied!" 