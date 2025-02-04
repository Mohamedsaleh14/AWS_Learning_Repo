## Install SAM CLI

```bash
./aws_sam_cli_install.sh
```

## Build the project

```bash
sam build \
--template-file ./template.yaml
```

## Check CloudFormation template to ensure its valid format

```bash
cfn-lint template.yaml
```

## Deploy our Lambda Function

```bash
sam deploy \
--template-file ./.aws-sam/build/template.yaml \
--stack-name "inline-lambda-py" \
--capabilities "CAPABILITY_IAM"
```
