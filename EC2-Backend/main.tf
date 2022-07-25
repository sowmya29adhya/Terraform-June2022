resource "aws_instance" "terraform-instance" {
	instance_type = var.instance-type
	ami = var.ami
	key_name = "june2022-sydney"
	tags = {
			Name = var.instance-name
	}
}









