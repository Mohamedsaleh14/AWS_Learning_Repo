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
--stack-name "zip-local-lambda-py" \
--capabilities "CAPABILITY_IAM" \
--s3-bucket "mybucket-lambda-zip-example" \
--config-file "$(pwd)/samconfig.toml"

```

