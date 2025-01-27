#!/usr/bin/env bash

echo "Creating VPC - Give it a name: "

set -e

if [ -z "$1" ]; then
    echo "No Argument given"
    exit 1
fi

VPC_NAME=$1

# Create our VPC
VPC_ID=$(aws ec2 create-vpc \
    --cidr-block 10.0.0.0/16 \
    --region eu-central-1 \
    --tag-specifications "ResourceType=vpc,Tags=[{Key=Name,Value=${VPC_NAME}}]" \
    --query 'Vpc.{VpcId:VpcId}' \
    --output text)

echo $VPC_ID

# Turn on Hostname
aws ec2 modify-vpc-attribute \
    --vpc-id $VPC_ID \
    --enable-dns-hostnames \
    --region eu-central-1 \
    --output text

# Create an IGW (Internet gateway)
IGW_ID=$(aws ec2 create-internet-gateway \
    --region eu-central-1 \
    --tag-specifications "ResourceType=internet-gateway,Tags=[{Key=Name,Value=${VPC_NAME}-igw}]" \
    --query 'InternetGateway.{InternetGatewayId:InternetGatewayId}' \
    --output text)
echo $IGW_ID

# Attach The IGW
aws ec2 attach-internet-gateway \
    --vpc-id $VPC_ID \
    --internet-gateway-id $IGW_ID \
    --region eu-central-1 \
    --output text

# Create a new subnet
SUBNET_ID=$(aws ec2 create-subnet \
    --vpc-id $VPC_ID \
    --cidr-block 10.0.1.0/20 \
    --region eu-central-1 \
    --tag-specifications "ResourceType=subnet,Tags=[{Key=Name,Value=${VPC_NAME}-subnet}]" \
    --query 'Subnet.{SubnetId:SubnetId}' \
    --output text)

echo $SUBNET_ID

#Auto Assign Public IPv4 address to the subnet
aws ec2 modify-subnet-attribute \
    --subnet-id $SUBNET_ID \
    --map-public-ip-on-launch \
    --region eu-central-1 \
    --output text


#Get Route table from VPC
RT_ID=$(aws ec2 describe-route-tables \
    --filters "Name=vpc-id,Values=${VPC_ID}" \
    --query 'RouteTables[0].RouteTableId' \
    --region eu-central-1 \
    --output text)

echo $RT_ID

# Explicitly associate subnet
aws ec2 associate-route-table \
    --route-table-id $RT_ID \
    --subnet-id $SUBNET_ID \
    --region eu-central-1 \
    --output text

#Add a route for our RT (RouteTable) to our IGW
aws ec2 create-route \
    --route-table-id $RT_ID \
    --destination-cidr-block 0.0.0.0/0 \
    --gateway-id $IGW_ID \
    --region eu-central-1 \
    --output text 