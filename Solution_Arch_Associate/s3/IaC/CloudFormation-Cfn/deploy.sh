#!/usr/bin/env bash

#Delopy s3 bucket via cloudformation
echo "Deploy s3 bucket via CFN"

# Exit immeditely if any command returns a non-zero status
set -e

#check for bucket name 
if [ -z "$1" ]; then
    echo "No bucket name provided"
    exit 1
fi

STACK_NAME=$1

aws cloudformation deploy \
--template-file template.yaml \
--stack-name $STACK_NAME \
--no-execute-changeset \
--region us-east-2 