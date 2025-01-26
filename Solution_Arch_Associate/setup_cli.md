# Setting Up AWS Environment Variables and Configuring AWS CLI

This guide provides step-by-step instructions to set up AWS environment variables, verify the setup, enable auto-prompt for AWS CLI, and make the changes permanent in a `zsh` shell.

---

## **1. Add AWS Environment Variables**

After generating your AWS access key and secret key from the AWS Management Console, set the following environment variables:

```bash
export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
export AWS_DEFAULT_REGION=us-west-2
```

Replace `YOUR_ACCESS_KEY` and `YOUR_SECRET_KEY` with your actual AWS credentials.

---

## **2. Verify the Setup**

Run the following command to confirm that the environment variables are set up correctly and the AWS CLI is authenticated:
```bash
aws sts get-caller-identity
```

This should return details about the authenticated AWS account, including the account ID, user, or role.

---

## **3. Enable Auto-Prompt for AWS CLI**

To enable auto-prompt for the AWS CLI, use the following command:
```bash
export AWS_CLI_AUTO_PROMPT=on-partial
```

This enables tab completion and interactive suggestions for AWS CLI commands.

---

## **4. Make Changes Permanent in `zsh`**

To ensure the environment variables and auto-prompt settings persist across sessions:

1. Open the `~/.zshrc` file:
   ```bash
   nano ~/.zshrc
   ```

2. Add the following lines at the end of the file:
   ```bash
   export AWS_ACCESS_KEY_ID=YOUR_ACCESS_KEY
   export AWS_SECRET_ACCESS_KEY=YOUR_SECRET_KEY
   export AWS_CLI_AUTO_PROMPT=on-partial
   ```

3. Save and exit the editor (`Ctrl+O`, `Enter`, `Ctrl+X`).

4. Reload the `~/.zshrc` file to apply the changes:
   ```bash
   source ~/.zshrc
   ```

---

## **5. Final Check**

To confirm everything is set up correctly:
- Verify your AWS credentials:
  ```bash
  aws sts get-caller-identity
  ```
- Test the auto-prompt feature:
  ```bash
  aws s3 ls [Tab]
  ```
## **6. Correct way to store Access keys**

Use the following command to save the credentials safely in TOML file format in ~/.aws/credentials
```bash
aws configure
```
You can also add a different profile for Access key and secret using the following cmd. Provide the PROFILE_NAME you want to add.
```bash
aws configure --profile $PROFILE_NAME
```
## **7. Configuration files**

Use the following configuration files
- `~/.aws/credentials`: Used to store credentials e.g., AWS Access Key and Secret, that basicly they will be updated using cmd `aws configure`
- `~/.aws/config`: Used to store prefered region and prefered output formate

---
