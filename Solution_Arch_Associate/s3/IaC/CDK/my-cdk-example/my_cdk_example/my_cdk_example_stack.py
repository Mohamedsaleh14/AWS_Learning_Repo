from aws_cdk import (
    Stack
)
from aws_cdk.aws_s3 import Bucket
from constructs import Construct

class MyCdkExampleStack(Stack):
    def __init__(self, scope: Construct, construct_id: str, **kwargs) -> None:
        super().__init__(scope, construct_id, **kwargs)

        # Create basic S3 bucket
        bucket = Bucket(self, "cdk-s3-simple-example")
