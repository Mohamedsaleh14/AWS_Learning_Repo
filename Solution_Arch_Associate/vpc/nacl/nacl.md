## Get VPC ID from VPC name: project-vpc

```bash
aws ec2 describe-vpcs \
--filters "Name=tag:Name,Values=project-vpc" \
--query "Vpcs[*].VpcId" \
--output text
```
## Create a NACL

```bash
aws ec2 create-network-acl --vpc-id vpc-0d665be8e8bd6e92c
```

## Add Entry to NACL
```bash
aws ec2 create-network-acl-entry \
--network-acl-id acl-0d5f5d15dc9969e3d \
--ingress \
--rule-number 90 \
--protocol -1 \
--port-range From=0,To=65535 \
--cidr-block $IP/32 \
--rule-action deny
```

## Get AMI for Amazon Linux 2

Grab the latest AMI2 Linux 2 ID in order to put the AMI in the template yaml file

```bash
aws ec2 describe-images \
--owners amazon \
--filters "Name=name,Values=amzn2-ami-hvm-*-x86_64-gp2" "Name=state,Values=available" \
--query "sort_by(Images, &CreationDate)[-1].ImageId" \
--region eu-central-1 \
--output text
```
