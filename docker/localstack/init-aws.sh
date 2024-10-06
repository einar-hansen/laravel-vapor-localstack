#!/bin/bash

# Create SQS queue
echo "Creating SQS queue"
awslocal sqs create-queue --queue-name "$SQS_QUEUE"

# Create S3 bucket
echo "Creating S3 bucket"
awslocal s3 mb s3://"$S3_BUCKET"

# Verify SES email
echo "Creating SES email"
awslocal ses verify-email-identity --email "$SES_EMAIL"

# Create DynamoDB table
if ! awslocal dynamodb describe-table --table-name "$DYNAMODB_TABLE" > /dev/null 2>&1; then
    echo "Creating DynamoDB table"
    awslocal dynamodb create-table \
        --table-name "$DYNAMODB_TABLE" \
        --attribute-definitions \
            AttributeName=key,AttributeType=S \
        --key-schema \
            AttributeName=key,KeyType=HASH \
        --provisioned-throughput \
            ReadCapacityUnits=10,WriteCapacityUnits=5
else
    echo "DynamoDB table already exists"
fi
