

echo ""
echo ""
echo ""
echo ""
echo "#########################################"
echo "#########################################"
echo "#########################################"
echo "#########################################"

#!/bin/bash

# Set AWS region (optional, specify if needed)
AWS_REGION="us-east-1"

# Get the list of all S3 buckets in the account
echo "Fetching list of S3 buckets..."
buckets=$(aws s3api list-buckets --query "Buckets[].Name" --output text --region $AWS_REGION)

if [ -z "$buckets" ]; then
  echo "No buckets found in the account."
  exit 1
fi

# Loop through each bucket and get the bucket policy
for bucket in $buckets; do
  echo "Fetching policy for bucket: $bucket"
  
  # Try to get the bucket policy
  policy=$(aws s3api get-bucket-policy --bucket $bucket --query "Policy" --output text --region $AWS_REGION)

  # Check if the bucket has a policy
  if [ "$policy" == "None" ]; then
    echo "No policy found for bucket: $bucket"
  else
    echo "Policy for bucket $bucket:"
    echo "$policy"
  fi
  
  echo "----------------------------------------"
done

echo "Done fetching all bucket policies."
