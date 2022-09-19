terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

resource "aws_instance" "test_ec2" {
  ami           = var.ami
  instance_type = var.instance_type
  iam_instance_profile = "sandi_terra_ssm"
  key_name =  "${var.keypair_name}"
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
    network_interface_id = var.network_interface_id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }
}
