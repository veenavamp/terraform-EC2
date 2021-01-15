resource "aws_instance" "example" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  #for_each      = data.aws_subnet_ids.selected.ids

  # the VPC subnet
  subnet_id = tolist(data.aws_subnet_ids.selected.ids)[0]

  # the security group
  vpc_security_group_ids = [aws_security_group.allow-ssh.id]

  # the public SSH key
  key_name = aws_key_pair.mykeypair.key_name

  tags = {
    Name = "example"
    ENV  = var.env
    type = "terraform"
  }
}


data "aws_subnet_ids" "private" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-public-1"
  }
}

data "aws_vpc" "selected" {
  tags = {
    Name = "*demo*"
  }
}

data "aws_subnet_ids" "selected" {
   vpc_id = data.aws_vpc.selected.id

  tags = {
    Name = "Demo-public-1"
  }
}
