#!/usr/bin/env bash
echo "Sync"

# Exit immeditely if any command returns a non-zero status
set -e

#check for bucket name 
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

#check for filname prefix
if [ -z "$2" ]; then
    echo "No bucket name provided"
    exit 1
fi

BUCKET_NAME=$1
FILENAME_PREFIX=$2

#The place where output files are stored
OUTPUT_DIR="/home/saleh/Documents/temp/s3-bash-scripts"

# Check if the folder exists
if [ -d "$OUTPUT_DIR" ]; then
  echo "Folder exists. Removing it..."
  rm -rf "$OUTPUT_DIR"
  echo "Folder removed successfully."
else
  echo "Folder does not exist. Nothing to remove."
fi

mkdir -p $OUTPUT_DIR

#To generate random number
NUM_FILES=$((random % 6 + 5))

# to determine how many files to create
for ((i=1; i<=$NUM_FILES; i++)); do
    # Generate a random filename
    FILENAME="$OUTPUT_DIR/${FILENAME_PREFIX}_$i.txt"

    #Generate random data and write it to the file
    dd if=/dev/urandom of="$FILENAME" bs=1024 count=$((RANDOM % 1024 + 1)) 2>/dev/null
done

tree $OUTPUT_DIR

aws s3 sync $OUTPUT_DIR s3://$BUCKET_NAME/files