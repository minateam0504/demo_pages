#!/bin/bash

echo "Replacing image links with appropriate icons across all screens..."

# First, let's modify the car-seats-listing.html product cards to use icons
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Nuna PIPA RX">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-baby-carriage" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Nuna PIPA Next">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-car-seat" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Graco SnugRide">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-car-alt" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Uppababy Mesa">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-child" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Britax One4Life">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-chair" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;
find /private/tmp/mina -name "car-seats-listing.html" -exec sed -i '' 's|<img src=".*" alt="Chicco KeyFit 30">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-baby" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;

# Replace images in the buyer-category.html
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="Car Seats">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-car-seat" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="Strollers">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-baby-carriage" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="Cribs & Bassinets">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-bed" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="High Chairs">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-chair" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="Toys">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-gamepad" style="font-size: 60px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "buyer-category.html" -exec sed -i '' 's|<img src=".*" alt="Clothes">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0;"><i class="fas fa-tshirt" style="font-size: 60px; color: var(--sage-green);"></i></div>|g' {} \;

# Replace other product images
find /private/tmp/mina -name "seller-step*.html" -exec sed -i '' 's|<img src=".*" alt="Nuna PIPA.*" class="product-image">|<div style="height: 180px; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0; border-radius: 8px;"><i class="fas fa-car-seat" style="font-size: 80px; color: var(--terracotta);"></i></div>|g' {} \;
find /private/tmp/mina -name "seller-step*.html" -exec sed -i '' 's|<img src=".*" class="uploaded-image" id="uploadedImage">|<div style="height: 180px; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0; border-radius: 8px;" class="uploaded-image" id="uploadedImage"><i class="fas fa-car-seat" style="font-size: 80px; color: var(--terracotta);"></i></div>|g' {} \;

# Replace buyer product image
find /private/tmp/mina -name "buyer-product.html" -exec sed -i '' 's|<img src=".*" class="main-image" alt=".*">|<div style="height: 320px; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0; border-radius: 8px;"><i class="fas fa-car-seat" style="font-size: 100px; color: var(--terracotta);"></i></div>|g' {} \;

# Take care of thumbnail images
find /private/tmp/mina -name "buyer-product.html" -exec sed -i '' 's|<img src=".*" class="thumbnail-image" alt=".*">|<div style="height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: #f0f0f0; border-radius: 4px;"><i class="fas fa-car-seat" style="font-size: 20px; color: var(--terracotta);"></i></div>|g' {} \;

# Replace user profile images (using different syntax to avoid escape issues)
find /private/tmp/mina -name "*.html" -exec sed -i "" "s|<img src=\".*\" alt=\"Julia.*profile\" class=\"user-avatar\">|<div style=\"height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: var(--sage-green); border-radius: 50%;\"><i class=\"fas fa-user\" style=\"font-size: 22px; color: white;\"></i></div>|g" {} \;
find /private/tmp/mina -name "*.html" -exec sed -i "" "s|<img src=\".*\" alt=\"Morgan.*profile\" class=\"user-avatar\">|<div style=\"height: 100%; width: 100%; display: flex; justify-content: center; align-items: center; background-color: var(--terracotta); border-radius: 50%;\"><i class=\"fas fa-user\" style=\"font-size: 22px; color: white;\"></i></div>|g" {} \;

echo "Image links replaced with icons!" 