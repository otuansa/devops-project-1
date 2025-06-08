
#!/bin/bash
cd /home/ubuntu

# Install required packages
yes | sudo apt update
yes | sudo apt install -y python3 python3-pip python3.12-venv git

# Clone the repo
git clone https://github.com/Emstev/python-mysql-db-proj-1.git
cd python-mysql-db-proj-1

# Ensure setup script is executable and run it
chmod +x setup-env.sh
./setup-env.sh
