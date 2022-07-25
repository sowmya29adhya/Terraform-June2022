output "instance-id" {
	value = aws_instance.terraform-instance.*.id
}

output "public-ip" {
	value = aws_instance.terraform-instance.*.public_ip
}
