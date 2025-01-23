#!/usr/bin/env bash
echo "Delete objects"

# Exit immeditely if any command returns a non-zero status
set -e

#check for bucket name 
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

BUCKET_NAME=$1

# Step 1: Get the list of object keys and construct the required JSON
JSON_INPUT=$(aws s3api list-objects-v2 \
--bucket $BUCKET_NAME \
--query 'Contents[].Key' \
--output json | jq '{Objects: [.[] | {Key: .}]}')

# Step 2: Use the constructed JSON to delete objects
aws s3api delete-objects \
--bucket $BUCKET_NAME \
--delete "$JSON_INPUT"
