variable "ami_id" {}
variable "instance_type" {}
variable "tag_name" {}
variable "public_key" {}
variable "subnet_id" {}
variable "sg_enable_ssh_https" {}
variable "enable_public_ip_address" {}
variable "user_data_install_apache" {}
variable "ec2_sg_name_for_python_api" {}

output "ssh_connection_string_for_ec2" {
  value = format("%s%s", "ssh -i /home/ubuntu/keys/mykeypair1 ubuntu@", aws_instance.dev_proj_1_ec2.public_ip)
}

output "dev_proj_1_ec2_instance_id" {
  value = aws_instance.dev_proj_1_ec2.id
}

resource "aws_instance" "dev_proj_1_ec2" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name = aws_key_pair.dev_proj_key.key_name
  tags = {
    Name = var.tag_name
  }
  key_name                    = "mykeypair1"
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.sg_enable_ssh_https, var.ec2_sg_name_for_python_api]
  associate_public_ip_address = var.enable_public_ip_address

  user_data = var.user_data_install_apache

  metadata_options {
    http_endpoint = "enabled"  # Enable the IMDSv2 endpoint
    http_tokens   = "required" # Require the use of IMDSv2 tokens
  }
}

resource "aws_key_pair" "dev_proj_1_public_key" {
  key_name   = "mykeypair1"
  public_key = var.public_key
}

# Option A: If you have the key pair file locally but need to create it in AWS
resource "aws_key_pair" "dev_proj_key" {
  key_name   = "mykeypair1"
  public_key = file("~/.ssh/id_rsa.pub") # Or path to your downloaded .pub file
}

# # Then reference it in your EC2 instance:
# resource "aws_instance" "dev_proj_1_ec2" {
#   key_name = aws_key_pair.dev_proj_key.key_name
#   # ... rest of config ...
# }