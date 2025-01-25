# Create websute 1

## Create a bucket

```bash
aws s3 mb s3://cors-training-example-st
```
## Change block pulblic access

```bash
aws s3api put-public-access-block \
--bucket cors-training-example-st \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```bash
aws s3api put-bucket-policy --bucket cors-training-example-st --policy file://policy.json
```
## Turn on static webstie hosting

```bash
aws s3api put-bucket-website --bucket cors-training-example-st --website-configuration file://website.json
```
## Upload our index.html file and include a resource that would be cross-origin

```bash
aws s3 cp index.html s3://cors-training-example-st
```
## View the website and see if the index.html is there

http://cors-training-example-st.s3-website.us-west-2.amazonaws.com
http://cors-training-example-st.s3-website-us-west-2.amazonaws.com

# Create Website 2

## Create a bucket

```bash
aws s3 mb s3://cors-training-example-st-01
```
## Change block pulblic access

```bash
aws s3api put-public-access-block \
--bucket cors-training-example-st-01 \
--public-access-block-configuration "BlockPublicAcls=true,IgnorePublicAcls=true,BlockPublicPolicy=false,RestrictPublicBuckets=false"
```

## Create a bucket policy

```bash
aws s3api put-bucket-policy --bucket cors-training-example-st-01 --policy file://policy_01.json
```
## Turn on static webstie hosting

```bash
aws s3api put-bucket-website --bucket cors-training-example-st-01 --website-configuration file://website.json
```
## Upload our index.html file and include a resource that would be cross-origin

```bash
aws s3 cp hello.js s3://cors-training-example-st-01
```
## Create API Gateway with Mock Response and then test the endpoint

```bash
curl -X POST -H "Content-Type: application/json" https://hwomsfdof9.execute-api.us-west-2.amazonaws.com/Prod/hello
```

## Set CORS on our bucket
```bash
aws s3api put-bucket-cors --bucket cors-training-example-st --cors-configuration file://cors.json
```