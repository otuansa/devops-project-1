bucket_name = "techteam-help"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2Dgoq0tJf6WUBVOQv17/5U/AaxSaULVBmAjuIW9OzwR9NQWhTgqE+N7RYTRRcAQf6px5bWS093Fr49rbSBj36Ze8CJuQzloBE+kkt0D4NCkP5npP+HO7r5UxRuXBlOzIIvPef"
ec2_ami_id     = "ami-03250b0e01c28d196"

ec2_user_data_install_apache = <<EOF
#!/bin/bash
cd /home/ubuntu

# Update and install required packages
yes | sudo apt update
yes | sudo apt install -y python3 python3-pip python3.12-venv git

# Clone the repo
git clone https://github.com/otuansa/python-mysql-db-proj-1.git
sleep 20
cd python-mysql-db-proj-1

# Run your setup-env.sh script
chmod +x setup-env.sh
./setup-env.sh

echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30
EOF

domain_name = "techteam.help"
