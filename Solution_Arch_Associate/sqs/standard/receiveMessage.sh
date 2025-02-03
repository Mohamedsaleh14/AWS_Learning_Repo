#!/usr/bin/env bash

echo "Send SQS message"

root_path=$(realpath .)
message_path="file://${root_path}/send-message.json"

QUEUE_URL=https://sqs.eu-central-1.amazonaws.com/850995538849/SQS-Standard-MyQueue-4WWzITDedheE

# By default, receive-message returns only 1 message even if max-number-of-messages is set higher
# This is because SQS does not guarantee to return the maximum number requested
# To reliably get all messages, you need to call receive-message in a loop
aws sqs receive-message \
    --queue-url $QUEUE_URL \
    --attribute-names All \
    --message-attribute-names All \
    --max-number-of-messages 10 \
    --wait-time-seconds 20  # Adding long polling to improve message retrieval

# Delete the message after receiving it
aws sqs delete-message \
    --queue-url $QUEUE_URL \
    --receipt-handle $RECEIPT_HANDLE