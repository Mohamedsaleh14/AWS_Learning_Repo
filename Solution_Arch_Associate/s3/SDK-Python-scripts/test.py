import boto3

# Boto3 will automatically use the credentials from environment variables
s3 = boto3.client("s3")

s3_client = boto3.client('s3')
region = s3_client.meta.region_name
print(f"AWS Default Region from boto3 client: {region}")
# List all S3 buckets
# response = s3.list_buckets()
# for bucket in response["Buckets"]:
#     print(f"Bucket Name: {bucket['Name']}")

# IaC with CloudFormation 3:54:00
