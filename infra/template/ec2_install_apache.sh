
#!/bin/bash
cd /home/ubuntu

# Install required packages
yes | sudo apt update
yes | sudo apt install python3 python3-pip

# Clone the repo
git clone https://github.com/otuansa/python-mysql-db-proj-1.git
sleep 20
cd python-mysql-db-proj-1

# Ensure setup script is executable and run it
chmod +x setup-env.sh
./setup-env.sh
pip3 install -r requirements.txt
echo 'Waiting for 30 seconds before running the app.py'
setsid python3 -u app.py &
sleep 30
