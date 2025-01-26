## Create a user with no permissions
We need to create a new user with no permissions and generate out access keys
```bash
aws iam create-user --user-name sts-machine-user
aws iam create-access-key --user-name sts-machine-user
```
## Add another profile to the TOML credential file 

```bash
aws configure --profile sts_user
```

## Example using different profile saved in the credentials

```bash
aws sts get-caller-identity --profile sts_user
```

## Make sure you don't have access to S3

```bash
aws s3 ls --profile sts_user
```
The response should be:

`An error occurred (AccessDenied) when calling the ListBuckets operation: User: arn:aws:iam::850995538849:user/sts-machine-user is not authorized to perform: s3:ListAllMyBuckets because no identity-based policy allows the s3:ListAllMyBuckets action`
## Create a Role
We need to create a role that will access a new resource. So a User with a role has to create a resource and give it AssumeRole policy first so that other user who don't have this privilage can use it later with assume role. that is why we have `/bin/deploy.sh'

# Use new user credentials 

Give the other user the policy to assume Sts resources 
```bash
aws iam put-user-policy \
--user-name sts-machine-user \
--policy-name StsAssumePolicy \
--policy-document file://policy.json
```

Start assuming the role, so that you get temperory access credentials

```bash
aws sts assume-role \
--role-arn arn:aws:iam::850995538849:role/my-sts-example-stack-StsRole-GyPTyoDUKsTl \
--role-session s3-sts-learning-example \
--profile sts_user
```
Test assumed credentials after saving the temp credentials in `~/.aws/credentials`
add the following lines

```bash
[assumed]
aws_access_key_id = XXXXXXXXXXXXXXXXXX
aws_secret_access_key = xxxxxxxxxxxxxxxxxxxxxxxx
aws_session_token = xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```
To make sure that the assumed profile is working correct
```bash
aws sts get-caller-identity --profile assumed
```

## Cleanup

Tear down your cloudformation stack via the AWS Management Console

```bash
aws iam delete-user-policy --user-name sts-machine-user --policy-name StsAssumePolicy
aws iam delete-access-key --access-key-id AKIA4MI2JNOQ52GMSRNZ --user-name sts-machine-user
aws iam delete-user --user-name sts-machine-user
```