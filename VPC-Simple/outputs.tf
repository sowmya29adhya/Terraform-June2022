output "instance-id" {
	value = aws_instance.terraform_instance.id
}

output "public-ip" {
	value = aws_instance.terraform_instance.public_ip
}

output "vpc-id" {
	value = aws_vpc.terraform_vpc.id
}

output "subnet-id" {
	value = aws_subnet.terraform_subnet.id
}