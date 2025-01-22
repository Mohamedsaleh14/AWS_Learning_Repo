resource "aws_s3_bucket" "My-aws_s3_bucket" {
  #bucket = "my-tf-test-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}