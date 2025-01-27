#!/usr/bin/env bash

echo "Deleting the VPC---Provide the name of vpc: "


if [ -z "$1" ]; then
    echo "No Argument given"
    exit 1
fi

VPC_NAME=$1


VPC_ID=$(aws ec2 describe-vpcs \
    --filters "Name=tag:Name,Values=${VPC_NAME}" \
    --query "Vpcs[0].VpcId" \
    --output text)

# Delete VPC
aws ec2 delete-vpc --vpc-id $VPC_ID