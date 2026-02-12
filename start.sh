#!/bin/bash
echo "=== Starting deployment ==="
echo "Unzipping VDMSHOP_FULL.zip..."
unzip -o VDMSHOP_FULL.zip

echo ""
echo "=== Listing root directory ==="
ls -la

echo ""
echo "=== Finding index.php file ==="
INDEX_PATH=$(find . -name "index.php" -type f | head -n 1)

if [ -z "$INDEX_PATH" ]; then
    echo "ERROR: index.php not found!"
    echo "=== Listing all PHP files ==="
    find . -name "*.php" -type f
    exit 1
fi

echo "Found index.php at: $INDEX_PATH"

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
