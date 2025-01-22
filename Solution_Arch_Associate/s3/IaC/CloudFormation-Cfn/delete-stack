#!/usr/bin/env bash

#Delopy s3 bucket via cloudformation
echo "Delete cloudformation stack"

# Exit immeditely if any command returns a non-zero status
set -e

#check for bucket name 
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

STACK_NAME=$1

aws cloudformation delete-stack \
--stack-name $STACK_NAME \
--region us-east-2