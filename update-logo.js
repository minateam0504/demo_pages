/**
 * Script to update all HTML files to include the Mina logo
 * Run with: node update-logo.js
 */

const fs = require('fs');
const path = require('path');

// Get all HTML files in the directory
const getAllHtmlFiles = (dir) => {
    const files = fs.readdirSync(dir);
    return files.filter(file => {
        const filePath = path.join(dir, file);
        return fs.statSync(filePath).isFile() && path.extname(file) === '.html';
    }).map(file => path.join(dir, file));
};

// CSS link to add to all HTML files
const cssLinkToAdd = '<link rel="stylesheet" href="assets/mina-logo.css">';

// Update each HTML file to include the logo CSS
const updateHtmlFiles = (files) => {
    files.forEach(file => {
        try {
            let content = fs.readFileSync(file, 'utf8');
            
            // Skip if already includes the mina-logo.css
            if (content.includes('mina-logo.css')) {
                console.log(`File ${file} already has logo CSS. Skipping.`);
                return;
            }
            
            // Add CSS link after the other stylesheets
            if (content.includes('</head>')) {
                const fontAwesomeLink = '<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">';
                if (content.includes(fontAwesomeLink)) {
                    content = content.replace(
                        fontAwesomeLink,
                        `${fontAwesomeLink}\n    ${cssLinkToAdd}`
                    );
                } else {
                    content = content.replace(
                        '</head>',
                        `    ${cssLinkToAdd}\n</head>`
                    );
                }
            }
            
            // Replace old logo containers with the new logo
            // Looking for common logo patterns
            const logoPatterns = [
                // Pattern 1: div with class logo-text containing "Mina"
                {
                    regex: /<div class="logo-text">Mina<\/div>/g,
                    replacement: `<div class="mina-header-logo">
                <svg class="mina-header-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <!-- Cloud shape -->
                    <path d="M220 170C234.5 170 246 158.5 246 144C246 129.5 234.5 118 220 118C219.3 118 218.6 118 217.9 118.1C214.4 104.2 202 94 187 94C171.5 94 158.8 104.9 156 119.2C152.4 116.7 148.1 115.3 143.5 115.3C132.9 115.3 124.2 123.2 123 133.4C115.2 136.6 110 144.3 110 153C110 165.2 120.2 175 132.5 175" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/>
                    
                    <!-- Stroller -->
                    <circle cx="160" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <circle cx="220" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <path d="M235 210H240C242.8 210 245 207.8 245 205V195C245 192.2 242.8 190 240 190H235" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/>
                    <path d="M190 130V210" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 170H235" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 130C145 130 167 130 190 130C213 130 190 170 190 170H145V130Z" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 130H190L190 170" fill="#D9DFCC" stroke="#4A4656" stroke-width="9"/>
                </svg>
                <div class="mina-header-logo-text">mina</div>
            </div>`
                },
                // Pattern 2: logo container with class "logo" containing "M"
                {
                    regex: /<div class="logo-container">\s*<div class="logo">M<\/div>\s*<\/div>/g,
                    replacement: `<div class="mina-centered-logo">
                <svg class="mina-centered-logo-img" viewBox="0 0 280 280" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <!-- Cloud shape -->
                    <path d="M220 170C234.5 170 246 158.5 246 144C246 129.5 234.5 118 220 118C219.3 118 218.6 118 217.9 118.1C214.4 104.2 202 94 187 94C171.5 94 158.8 104.9 156 119.2C152.4 116.7 148.1 115.3 143.5 115.3C132.9 115.3 124.2 123.2 123 133.4C115.2 136.6 110 144.3 110 153C110 165.2 120.2 175 132.5 175" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/>
                    
                    <!-- Stroller -->
                    <circle cx="160" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <circle cx="220" cy="210" r="14" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <path d="M235 210H240C242.8 210 245 207.8 245 205V195C245 192.2 242.8 190 240 190H235" stroke="#4A4656" stroke-width="9" stroke-linecap="round"/>
                    <path d="M190 130V210" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 170H235" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 130C145 130 167 130 190 130C213 130 190 170 190 170H145V130Z" fill="#9B9E8A" stroke="#4A4656" stroke-width="9"/>
                    <path d="M145 130H190L190 170" fill="#D9DFCC" stroke="#4A4656" stroke-width="9"/>
                </svg>
                <div class="mina-centered-logo-text">mina</div>
            </div>`
                }
            ];
            
            // Apply replacements
            logoPatterns.forEach(pattern => {
                content = content.replace(pattern.regex, pattern.replacement);
            });
            
            // Remove old CSS for the logo if present
            const cssToRemove = [
                /\.logo-container\s*{[^}]*}/g,
                /\.logo\s*{[^}]*}/g,
                /\.logo-text\s*{[^}]*}/g
            ];
            
            cssToRemove.forEach(pattern => {
                content = content.replace(pattern, '');
            });
            
            // Write the updated content back to the file
            fs.writeFileSync(file, content, 'utf8');
            console.log(`Updated ${file}`);
        } catch (error) {
            console.error(`Error updating ${file}:`, error);
        }
    });
};

// Main execution
const main = () => {
    const htmlFiles = getAllHtmlFiles(path.resolve(__dirname));
    console.log(`Found ${htmlFiles.length} HTML files.`);
    updateHtmlFiles(htmlFiles);
    console.log('Logo update complete!');
};

main(); 