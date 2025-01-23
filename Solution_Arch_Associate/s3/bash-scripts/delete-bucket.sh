#!/usr/bin/env bash
echo "Deleting a bucket"

#check if at least one argument is provided
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

BUCKET_NAME=$1

aws s3api delete-bucket --bucket $BUCKET_NAME
