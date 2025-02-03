#!/usr/bin/env bash

echo "Send SQS message"

root_path=$(realpath .)
message_path="file://${root_path}/send-message.json"

QUEUE_URL=https://sqs.eu-central-1.amazonaws.com/850995538849/SQS-Standard-MyQueue-4WWzITDedheE

aws sqs send-message \
    --queue-url $QUEUE_URL \
    --message-body "Hello from CLI" \
    --delay-seconds 0 \
    --message-attributes $message_path