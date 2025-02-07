## Install SAM CLI

```bash
./aws_sam_cli_install.sh
```

## Build the project

```bash
sam build \
--template-file ./template.yaml
```

```bash
sam package \
--config-file "$(pwd)/samconfig.toml" \
--template-file ./.aws-sam/build/template.yaml \
--output-template-file ./.aws-sam/build/package.yaml \
--s3-prefix "zip-package-python" \
--s3-bucket "lambda-example-packaged-python"
```

## Check CloudFormation template to ensure its valid format

```bash
cfn-lint template.yaml
```

## Deploy our Lambda Function

```bash
sam deploy \
--template-file ./.aws-sam/build/package.yaml \
--stack-name "zip-package-lambda-py" \
--capabilities "CAPABILITY_IAM" \
--config-file "$(pwd)/samconfig.toml"
##--s3-bucket "mybucket-lambda-zip-example" \

```
