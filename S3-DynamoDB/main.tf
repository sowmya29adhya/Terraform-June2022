provider "aws" {
	region = "ap-southeast-2"
}

resource "aws_s3_bucket" "s3bucket-remote-state" {
	bucket = "s3bucket-remote-state-812389"
	force_destroy = true
	
}

resource "aws_s3_bucket_versioning" "s3bucket-remote-state-versioning" {
  bucket = aws_s3_bucket.s3bucket-remote-state.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_dynamodb_table" "dynamodb-remote-state" {
  name           = "dynamodb-remote-state"
  billing_mode   = "PROVISIONED"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}