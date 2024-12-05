#!/bin/bash

echo "Updating package index..."
sudo apt update -y

echo "Installing Apache..."
sudo apt install apache2 -y

echo "Enabling Apache to start on boot..."
sudo systemctl enable apache2

echo "Starting Apache service..."
sudo systemctl start apache2

echo "Configuring firewall..."
sudo ufw allow 'Apache'
sudo ufw reload

echo "Checking Apache status..."
sudo systemctl status apache2

echo "Apache installation and configuration complete. Visit your server's IP address to verify."
