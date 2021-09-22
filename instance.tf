resource "aws_instance" "workstation" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  #for_each      = data.aws_subnet_ids.selected.ids

  # the VPC subnet
  subnet_id = tolist(data.aws_subnet_ids.var.subnet.ids)[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name
  user_data = local.template_file_int

  tags = {
    Name = "workstation"
    type = "terraform"
  }
}


data "aws_subnet_ids" "private" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-private-1"
  }
}

data "aws_vpc" "selected" {
  tags = {
    Name = "*demo*"
  }
}

data "aws_subnet_ids" "public" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-public-1"
  }
}

locals {
   template_file_int  = templatefile("./docker_ubuntu_install.tpl")
}

