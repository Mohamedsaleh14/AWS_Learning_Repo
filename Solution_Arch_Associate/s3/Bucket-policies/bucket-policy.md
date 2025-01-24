## Create a bucket 

```bash
aws s3 mb s3://bucket-policy-example-st-88
```
## Update the bucket policy

```bash
aws s3api put-bucket-policy --bucket bucket-policy-example-st-88 -- policy file://policy.json
````