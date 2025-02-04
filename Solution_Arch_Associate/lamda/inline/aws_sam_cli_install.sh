#!/usr/bin/env bash
echo "Installing AWS SAM CLI"

# Save the current directory
ORIGINAL_DIR=$(pwd)

# Change to Downloads folder
cd /home/saleh/Downloads || exit

# Download AWS SAM CLI (Corrected link, handle the redirecting)
curl -Lo awsSamCli.zip "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip"

# Verify ZIP file integrity
if ! unzip -t awsSamCli.zip >/dev/null 2>&1; then
    echo "Error: awsSamCli.zip is not a valid zip file. Download might have failed."
    exit 1
fi

# Extract and install
unzip awsSamCli.zip -d sam-installation
sudo ./sam-installation/install

# Verify installation
if command -v sam >/dev/null 2>&1; then
    echo "AWS SAM CLI installed successfully!"
    sam --version
else
    echo "Error: AWS SAM CLI installation failed."
fi

# Return to the original directory
cd "$ORIGINAL_DIR"

echo "Returned to $ORIGINAL_DIR"
