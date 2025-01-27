## If the Default VPC was deleted (By accident of intentionally)

Recreate the default VPC by running the following AWS CLI CMD
```bash 
aws ec2 create-default-vpc --region $GIVE_REGION
```