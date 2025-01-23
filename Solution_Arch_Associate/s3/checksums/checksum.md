# **Checksum Example**

## Createa new s3 bucket
```bash
aws s3 mb s3://checksums-example-learn
```
## Create a file that will do a checksum on
```bash
echo "Hello World" > myfile.txt
```

## Get a checksum of a file for md5
```bash
md5sum myfile.txt
```

The output will be:

`a66a86c11861cb0ebbb7d1408940ea8d  myfile.txt`

## Upload our file and look at its etag
```bash
aws s3 cp myfile.txt s3://checksums-example-learn
```
## Get the metadata of the object
```bash
aws s3api head-object --bucket checksum-example-learn --key myfile.txt
```
## Lets upload a file with a different checksum 
First change calculate another checksum with a different method e.g, CRC32
use file `calc_crc32` to calculate the crc32 that is compliant with AWS

## Now upload the file but with different checksum
So we use method put-object this time to specify different checksum mechanism, in this example is CRC32. 
```bash
aws s3api put-object \
--bucket="checksums-example-learn" \
--key="myfilecrc32.txt" \
--body="myfile.txt" \
--checksum-algorithm="CRC32" \
--checksum-crc32="vLhBTg=="
```

