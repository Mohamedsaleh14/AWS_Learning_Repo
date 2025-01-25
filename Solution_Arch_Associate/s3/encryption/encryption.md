## Create a bucket 

```bash
aws s3 mb s3://encryption-example-learning
```
## Create a file 

```bash
aws s3 cp hello.txt s3://encryption-example-learning
```
## Put object with encryption of KMS

```bash
aws s3api put-object --bucket encryption-example-learning --key hello.txt --body hello.txt \
--server-side-encryption aws:kms\
--ssekms-key-id <keyId>
```

## Put object with SSE-C (Failed attempt from the examples)

Generate out `encoded key`

```bash
export BASE64_ENCODED_KEY=$(openssl rand -base64 32)
echo $BASE64_ENCODED_KEY

export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | md5sum | awk '{print $1}' | base64 -w0)
```

```bash
aws s3api put-object \
--bucket encryption-example-learning \
--key hello.txt \
--body hello.txt \
--sse-customer-algorithm AES256\
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE
```

## Put object with SSE-C via aws s3

Generate the key

```bash
openssl rand -out ssec.key 32
```

```bash
aws s3 cp hello.txt s3://encryption-examplep-learning \
--sse-c AES256
--sse-c-key file://ssec.key
```

# ChatGpt Corrected the failed version

The instructor was trying to upload an object to an S3 bucket using **Server-Side Encryption with Customer-Provided Keys (SSE-C)**. This method allows you to provide your own encryption key to AWS when uploading an object. AWS uses this key to encrypt the object before storing it, and it requires you to supply the same key when accessing or downloading the object.

Here’s a step-by-step explanation and a corrected version of what was being attempted:

---

### 1. **Understanding SSE-C**

- **SSE-C** stands for Server-Side Encryption with Customer-provided keys.
- You (the customer) generate and manage the encryption keys instead of AWS.
- AWS will use your key to:
  - Encrypt the object during upload.
  - Decrypt the object during retrieval.
- AWS does not store your encryption key. You must provide it every time you interact with the object.

---

### 2. **Steps in the Instructor's Example**

1. **Generate a Base64-encoded Encryption Key**
   - The instructor used OpenSSL to generate a 256-bit (32-byte) random key and encode it in Base64 format:
     ```bash
     export BASE64_ENCODED_KEY=$(openssl rand -base64 32)
     echo $BASE64_ENCODED_KEY
     ```
   - This is the customer-provided key used for encryption and decryption.

2. **Generate the MD5 Hash of the Key**
   - AWS requires the **Base64-encoded MD5 hash** of the encryption key for verification purposes.
   - The instructor attempted to generate this hash:
     ```bash
     export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | md5sum | awk '{print $1}' | base64 -w0)
     ```
   - **Mistake in this step**: `echo -n` prints the raw string instead of the binary representation of the key. This causes the MD5 hash to be incorrect.

3. **Upload the Object Using AWS CLI**
   - The `put-object` command was used to upload the object (`hello.txt`) to an S3 bucket, specifying:
     - `--sse-customer-algorithm` as `AES256`.
     - `--sse-customer-key` as the generated Base64-encoded key.
     - `--sse-customer-key-md5` as the hash of the encryption key.

---

### 3. **Corrected Version**

Here’s how to fix the command and explanation for each step:

#### **Step 1: Generate a 32-byte Encryption Key**
```bash
export BASE64_ENCODED_KEY=$(openssl rand -base64 32)
echo $BASE64_ENCODED_KEY
```
- This generates a 256-bit random key in Base64 format. You need to keep this key secure because AWS will not store it for you.

#### **Step 2: Generate the Correct MD5 Hash**
The MD5 hash must be computed using the binary representation of the encryption key, not the Base64 string itself. Use `openssl` for this step:
```bash
export MD5_VALUE=$(echo -n $BASE64_ENCODED_KEY | base64 -d | openssl dgst -md5 -binary | base64)
```
- `base64 -d` decodes the Base64 key into its binary format.
- `openssl dgst -md5 -binary` computes the MD5 hash of the binary key.
- `base64` re-encodes the MD5 hash in Base64 format, as required by AWS.

#### **Step 3: Upload the Object**
Run the corrected AWS CLI command:
```bash
aws s3api put-object \
--bucket encryption-example-learning \
--key hello.txt \
--body hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE
```
- **Parameters Explained**:
  - `--bucket`: The name of the S3 bucket (`encryption-example-learning`).
  - `--key`: The key (file name) under which the object will be stored (`hello.txt`).
  - `--body`: The local file to upload (`hello.txt`).
  - `--sse-customer-algorithm`: Specifies the encryption algorithm (`AES256`).
  - `--sse-customer-key`: Your Base64-encoded encryption key.
  - `--sse-customer-key-md5`: The Base64-encoded MD5 hash of the key for validation.

---

### 4. **Important Notes**
1. **Key Management**:
   - AWS does not store your encryption key. Losing the key means you will not be able to retrieve the encrypted object.

2. **Verifying the Upload**:
   - After a successful upload, you can verify the encryption metadata:
     ```bash
     aws s3api head-object \
     --bucket encryption-example-learning \
     --key hello.txt \
     --sse-customer-algorithm AES256 \
     --sse-customer-key $BASE64_ENCODED_KEY \
     --sse-customer-key-md5 $MD5_VALUE
     ```

3. **Security**:
   - Store the encryption key securely, such as in a key management system or a secure vault, as it's crucial for decrypting the data.

Would you like further clarification or help with testing this?

### 5. To download the file

```bash
aws s3api get-object \
--bucket encryption-example-learning \
--key hello.txt \
hello.txt \
--sse-customer-algorithm AES256 \
--sse-customer-key $BASE64_ENCODED_KEY \
--sse-customer-key-md5 $MD5_VALUE
```
