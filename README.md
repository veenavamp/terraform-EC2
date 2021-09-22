# terraform-EC2
build Ec2 instance

this is used to create a workstation in the public subnet and will install docker kubectl helm and awscli

git clone https://github.com/thedevopsstore/terraform-EC2.git

terraform init

terraform plan

terraform apply

ssh -i mykey ubuntu@publicip in the output
