#!/bin/bash

# Variables - customize these
LAMBDA_NAME="myLambdaFunction"
RUNTIME="python3.11"
ROLE_ARN="arn:aws:iam::123456789012:role/service-role/my-lambda-role"
HANDLER="lambda_function.lambda_handler"
ZIP_FILE="function.zip"
REGION="us-east-1"
TIMEOUT=10
MEMORY_SIZE=128

# Check if function exists
aws lambda get-function --function-name $LAMBDA_NAME --region $REGION > /dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "Lambda function already exists. Updating code..."
    aws lambda update-function-code \
        --function-name $LAMBDA_NAME \
        --zip-file fileb://$ZIP_FILE \
        --region $REGION
else
    echo "Creating new Lambda function..."
    aws lambda create-function \
        --function-name $LAMBDA_NAME \
        --runtime $RUNTIME \
        --role $ROLE_ARN \
        --handler $HANDLER \
        --zip-file fileb://$ZIP_FILE \
        --timeout $TIMEOUT \
        --memory-size $MEMORY_SIZE \
        --region $REGION
fi
echo "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
