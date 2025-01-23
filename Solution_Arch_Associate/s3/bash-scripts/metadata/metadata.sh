#!/usr/bin/env bash
echo "Creating a bucket"

#check if at least one argument is provided
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

BUCKET_NAME=$1

# Create a bucket with the provided name
aws s3api create-bucket --bucket $BUCKET_NAME --region us-west-2 --create-bucket-configuration LocationConstraint=us-west-2

# Create a new file
echo "Hello Mars" > hello.txt

#Upload file with metadata
aws s3api put-object --bucket $BUCKET_NAME --key hello.txt --body hello.txt --metadata '{"author": "John Doe", "version": "1.0"}'

# Get Metadata through head object
aws s3api head-object --bucket $BUCKET_NAME --key hello.txt

# Cleanup
# Uncomment the next CLI cmd to clean afterwards or use it in the terminal

# aws s3 rm s3://$BUCKET_NAME --rescursive
# aws s3 rb s3://$BUCKET_NAME
