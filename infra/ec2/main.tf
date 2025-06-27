variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_enable_ssh_https" {}
variable "enable_public_ip_address" {}
variable "user_data_install_flaskapp" {}
variable "ec2_sg_name_for_python_api" {}

output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i '/Users/Macbook/Downloads/Jenkins.pem' ubuntu@", aws_instance.dev_proj_1_ec2.public_ip)
}

output "dev_proj_1_ec2_instance_id" {
  value = aws_instance.dev_proj_1_ec2.id
}

resource "aws_instance" "dev_proj_1_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.tag_name
  }
  key_name                    = "Jenkins"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_address

  user_data = <<-EOF
    #!/bin/bash
    set -e

    apt update -y
    apt install -y python3.12-venv python3-pip git

    cd /home/ubuntu

    # Clone repo if not exists
    if [ ! -d python-mysql-db-proj-1 ]; then
      sudo -u ubuntu git clone https://github.com/otuansa/python-mysql-db-proj-1
    fi

    cd python-mysql-db-proj-1
    sudo chown -R ubuntu:ubuntu .

    # Setup venv and install dependencies as ubuntu user
    sudo -u ubuntu bash -c '
      python3 -m venv venv
      ./venv/bin/pip install --upgrade pip
      ./venv/bin/pip install flask pymysql gunicorn
    '

    # Start Gunicorn as ubuntu user in background
    sudo -u ubuntu nohup ./venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app > gunicorn.log 2>&1 &
  EOF

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }
}

# resource "aws_key_pair" "dev_proj_1_public_key" {
#  key_name   = "aws_key"
#  public_key = var.public_key
# }
