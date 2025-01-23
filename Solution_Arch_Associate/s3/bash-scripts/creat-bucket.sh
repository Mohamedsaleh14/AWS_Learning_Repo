#!/usr/bin/env bash
echo "Creating a bucket"

#check if at least one argument is provided
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

BUCKET_NAME=$1

aws s3api create-bucket --bucket $BUCKET_NAME \
--create-bucket-configuration=LocationConstraint=us-east-2 \
--query Location \
--output text \
--region us-east-2

