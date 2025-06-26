#!/bin/bash

# Fail on error
set -e

# Variables
APP_DIR="/home/ubuntu/python-mysql-db-proj-1"
VENV_DIR="$APP_DIR/venv"
LOG_FILE="$APP_DIR/gunicorn.log"
GUNICORN_CMD="$VENV_DIR/bin/gunicorn"
APP_MODULE="app:app"

# Update system and install Python venv
sudo apt update
sudo apt install -y python3.12-venv python3-pip

# Navigate to app directory
cd "$APP_DIR"

# Ensure correct permissions
sudo chown -R ubuntu:ubuntu .

# Set up virtual environment
python3 -m venv venv
source "$VENV_DIR/bin/activate"

# Install Python packages
pip install --upgrade pip
pip install flask pymysql gunicorn

# Stop any existing Gunicorn process (optional cleanup)
pkill gunicorn || true

# Start the Flask app with Gunicorn in background and log output
nohup "$GUNICORN_CMD" -w 4 -b 0.0.0.0:5000 "$APP_MODULE" > "$LOG_FILE" 2>&1 &

echo "Flask app started via Gunicorn and is listening on port 5000"








# #! /bin/bash
# # shellcheck disable=SC2164
# cd /home/ubuntu
# yes | sudo apt update
# yes | sudo apt install python3 python3-pip
# git clone https://github.com/otuansa/python-mysql-db-proj-1.git
# sleep 20
# # shellcheck disable=SC2164
# cd python-mysql-db-proj-1
# pip3 install -r requirements.txt
# echo 'Waiting for 30 seconds before running the app.py'
# setsid python3 -u app.py &
# sleep 30
