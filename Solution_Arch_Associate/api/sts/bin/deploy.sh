#!/usr/bin/env bash
echo "Deploy cloudformation, sts temp user example"

aws cloudformation deploy \
--template-file template.yaml \
--stack-name my-sts-example-stack \
--capabilities CAPABILITY_IAM