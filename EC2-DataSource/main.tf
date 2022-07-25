data "aws_instance" "terraform-data-ec2" {
	instance_tags = {
		Name = "data-source"
	}
}

output "public-ip" {
	value = data.aws_instance.terraform-data-ec2.public_ip
}

output "instance-id" {
	value = data.aws_instance.terraform-data-ec2.id
}

resource "null_resource" "run-provisioner" {
	connection {
		type = "ssh"
		user = "ubuntu"
		host = data.aws_instance.terraform-data-ec2.public_ip
		private_key = file("./june2022-sydney.pem")
	}

	provisioner "file" {
		source = "./script.sh"
		destination = "/home/ubuntu/script.sh"
	}
	
	provisioner "remote-exec" {
		inline = [
			"chmod u+x /home/ubuntu/script.sh",
			"sh /home/ubuntu/script.sh"
		]
	}
} 
