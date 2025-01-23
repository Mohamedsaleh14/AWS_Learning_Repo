#!/bin/bash

# Function to print usage instructions
usage() {
    echo "Usage: $0 <relative_file_path>"
    exit 1
}

# Check if the file path is provided
if [ "$#" -ne 1 ]; then
    usage
fi

# Input file (relative path)
FILE=$1

# Check if the file exists
if [ ! -f "$FILE" ]; then
    echo "Error: File '$FILE' not found."
    exit 1
fi

# Step 1: Use Python to calculate CRC32 in Base64
crc32_base64=$(python3 -c "
import zlib, base64
with open('$FILE', 'rb') as f:
    checksum = zlib.crc32(f.read()) & 0xFFFFFFFF
    print(base64.b64encode(checksum.to_bytes(4, 'big')).decode())
")

# Step 2: Print the result
echo "File: $FILE"
echo "CRC32 (Base64): $crc32_base64"
