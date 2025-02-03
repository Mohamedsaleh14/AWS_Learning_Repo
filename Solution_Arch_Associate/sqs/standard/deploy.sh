#!/usr/bin/env bash

echo "Deploy SQS Basic example"

STACK_NAME="SQS-Standard"

aws cloudformation deploy \
--template-file ./template.yaml \
--stack-name $STACK_NAME \
--no-execute-changeset \
--region eu-central-1 \
--capabilities CAPABILITY_NAMED_IAM