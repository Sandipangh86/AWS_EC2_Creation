terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      Version = "~>3.27"
    }
  }
	
  required_version = ">=0.14.9"
}

provider "aws" {
  version = "~>3.0"
  region  = "ap-south-1"
}

resource "aws_instance" "test_ec2" {
  ami           = "ami-06489866022e12a14"
  instance_type = "t2.micro"
  iam_instance_profile = "sandi_terra_ssm"
  key_name =  "key-terraform-key"
  user_data = <<EOF
 #!/bin/bash
 sleep 120
        sudo cd /
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        sudo ./aws/install
        sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
	sudo systemctl start amazon-ssm-agent
  	       EOF   
  tags ={
    Name = "test_terra_instance-2022-09-13T06:18:59Z"
    OS = "Amazon_linux"
  }
  network_interface {
    network_interface_id = "eni-0d4f43947b344f19d"
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}
