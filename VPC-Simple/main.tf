resource "aws_vpc" "terraform_vpc" {
  cidr_block = var.cidr
  tags = {
    Name = "Terraform-VPC"
  }
}

resource "aws_subnet" "terraform_subnet" {
  vpc_id     = aws_vpc.terraform_vpc.id
  cidr_block = "10.1.1.0/24"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "Terraform-Subnet"
  }
}

resource "aws_internet_gateway" "terraform_igw" {
  vpc_id = aws_vpc.terraform_vpc.id

  tags = {
    Name = "terraform-IGW"
  }
}

resource "aws_route_table" "terraform_rt" {
  vpc_id = aws_vpc.terraform_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.terraform_igw.id
  }

  tags = {
    Name = "Terraform-RT"
  }
}

resource "aws_route_table_association" "terraform_rta" {
  subnet_id      = aws_subnet.terraform_subnet.id
  route_table_id = aws_route_table.terraform_rt.id
}

resource "aws_security_group" "terraform_sg" {
  vpc_id      = aws_vpc.terraform_vpc.id

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

resource "aws_instance" "terraform_instance" {
	subnet_id = aws_subnet.terraform_subnet.id
	vpc_security_group_ids = [aws_security_group.terraform_sg.id]
	instance_type = var.instance-type
	ami = var.ami
	key_name = "june2022-sydney"
	tags = {
			Name = var.instance-name
	}
}







