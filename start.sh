#!/bin/bash
echo "=== Starting deployment ==="
echo "Unzipping VDMSHOP_FULL.zip..."
unzip -o VDMSHOP_FULL.zip

echo ""
echo "=== Listing root directory ==="
ls -la

echo ""
echo "=== Finding main index.php file (excluding Views directory) ==="
# Find index.php but exclude Views, views, templates, Templates directories
INDEX_PATH=$(find . -name "index.php" -type f ! -path "*/Views/*" ! -path "*/views/*" ! -path "*/templates/*" ! -path "*/Templates/*" | head -n 1)

if [ -z "$INDEX_PATH" ]; then
    echo "ERROR: Main index.php not found!"
    echo "=== Listing all index.php files ==="
    find . -name "index.php" -type f
    echo ""
    echo "=== Trying to find shop_online directory ==="
    if [ -d "shop_online" ]; then
        echo "Found shop_online directory, checking for index.php..."
        cd shop_online
        if [ -f "index.php" ]; then
            echo "Found index.php in shop_online root"
            pwd
            ls -la
            echo ""
            echo "=== Starting PHP server ==="
            php -S 0.0.0.0:$PORT
            exit 0
        elif [ -f "public/index.php" ]; then
            echo "Found index.php in shop_online/public"
            cd public
            pwd
            ls -la
            echo ""
            echo "=== Starting PHP server ==="
            php -S 0.0.0.0:$PORT
            exit 0
        fi
    fi
    echo "ERROR: Could not find main index.php!"
    exit 1
fi

echo "Found main index.php at: $INDEX_PATH"

# Get the directory containing index.php
INDEX_DIR=$(dirname "$INDEX_PATH")
echo "Index directory: $INDEX_DIR"

echo ""
echo "=== Changing to index directory ==="
cd "$INDEX_DIR"
pwd

echo ""
echo "=== Listing files in index directory ==="
ls -la

echo ""
echo "=== Starting PHP server ==="
php -S 0.0.0.0:$PORT
