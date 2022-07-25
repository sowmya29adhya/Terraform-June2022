resource "aws_security_group" "terraform_sg" {
  vpc_id      = "vpc-08fd91cfe0aecae9e"

  ingress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Terraform-SG"
  }
}

resource "aws_instance" "terraform-instance" {
	vpc_security_group_ids = [aws_security_group.terraform_sg.id]
	instance_type = var.instance-type
	ami = var.ami
	key_name = "june2022-sydney"
	tags = {
			Name = var.instance-name
	}

	connection {
		type = "ssh"
		user = "ubuntu"
		host = self.public_ip
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
	
	provisioner "local-exec" {
		command = "echo The public ip of the instance is ${aws_instance.terraform-instance.public_ip} > publicip.txt"
	}
	
	provisioner "file" {
		source = "./publicip.txt"
		destination = "/home/ubuntu/publicip.txt"
	}
	
	provisioner "local-exec" {
		when = destroy
		command = "echo The instance was deleted on `date` > destroy.txt"
		interpreter = ["bash", "-c"]
	}

}







