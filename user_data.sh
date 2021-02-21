#!bin/bash

sudo apt -y update
sudo apt install -y nginx

myip= 'curl http://0.0.0.0/latest/meta-data/local-ipv4'
echo "<h2>WebServ with IP: $myip</h2><b>Build by Terraform!"  > /var/www/html/index.html
sudo systemctl enable nginx
sudo systemctl start nginx