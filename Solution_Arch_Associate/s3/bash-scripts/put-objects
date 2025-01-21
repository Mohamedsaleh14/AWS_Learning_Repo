#!/usr/bin/env bash
echo "Put a single object"

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
FILENAME=$2

OBJECT_KEY=$(basename "$FILENAME")

aws s3api put-object \
--bucket $BUCKET_NAME \
--body $FILENAME \
--key $OBJECT_KEY