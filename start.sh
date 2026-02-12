#!/bin/bash
echo "=== Starting deployment ==="
echo "Unzipping VDMSHOP_FULL.zip..."
unzip -o VDMSHOP_FULL.zip

echo "=== Listing root directory ==="
ls -la

echo "=== Checking shop_online directory ==="
if [ -d "shop_online" ]; then
    cd shop_online
    echo "=== Inside shop_online ==="
    ls -la
    echo "=== Starting PHP server ==="
    php -S 0.0.0.0:$PORT
else
    echo "ERROR: shop_online directory not found!"
    echo "=== Listing all directories ==="
    find . -type d -maxdepth 2
    exit 1
fi
