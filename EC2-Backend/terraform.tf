terraform {
	backend "s3" {
		bucket = "s3bucket-remote-state-812389"
		key = "terraform/remotestate/ec2simple/terraform.tfstate"
		
		region = "ap-southeast-2"
		
		dynamodb_table = "dynamodb-remote-state"
		encrypt = true
	}
}