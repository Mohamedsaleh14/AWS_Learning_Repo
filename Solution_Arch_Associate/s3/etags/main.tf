terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.84.0"
    }
  }
}

provider "aws" {
  # Configuration options
}

resource "aws_s3_bucket" "My-aws_s3_bucket" {
}

resource "aws_s3_object" "object"{
    bucket = aws_s3_bucket.My-aws_s3_bucket.id
    key = "myfile.txt"
    source = "myfile.txt"
    etag = filemd5("myfile.txt")
}