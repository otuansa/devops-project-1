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

 user_data = <<-EOF
#!/bin/bash

# Install dependencies
apt update -y
apt install -y python3.12-venv python3-pip git

# Clone the repo if it doesn't exist
cd /home/ubuntu
if [ ! -d python-mysql-db-proj-1 ]; then
  sudo -u ubuntu git clone https://github.com/otuansa/python-mysql-db-proj-1
fi

cd python-mysql-db-proj-1
sudo chown -R ubuntu:ubuntu .

# Setup virtual environment and install packages
sudo -u ubuntu bash -c '
  python3 -m venv venv
  ./venv/bin/pip install --upgrade pip
  ./venv/bin/pip install flask pymysql gunicorn
'

# Create systemd service file
cat <<SERVICE | sudo tee /etc/systemd/system/flaskapp.service
[Unit]
Description=Gunicorn Flask App
After=network.target

[Service]
User=ubuntu
Group=ubuntu
WorkingDirectory=/home/ubuntu/python-mysql-db-proj-1
Environment="PATH=/home/ubuntu/python-mysql-db-proj-1/venv/bin"
ExecStart=/home/ubuntu/python-mysql-db-proj-1/venv/bin/gunicorn -w 4 -b 0.0.0.0:5000 app:app
Restart=always

[Install]
WantedBy=multi-user.target
SERVICE

# Enable and start the service
systemctl daemon-reload
systemctl enable flaskapp
systemctl start flaskapp
EOF


domain_name = "techteam.help"
