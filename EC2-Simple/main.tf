provider "aws" {
	region = "ap-southeast-2"
}

resource "aws_instance" "terraform-instance" {
	instance_type = "t2.micro"
	ami = "ami-0e040c48614ad1327"
	key_name = "june2022-sydney"
	tags = {
			Name = "terraform-ec2"
	}
}




