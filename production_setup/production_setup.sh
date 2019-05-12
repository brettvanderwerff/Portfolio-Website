#!/bin/bash
# Reference:
# https://www.digitalocean.com/community/tutorials/how-to-serve-flask-applications-with-gunicorn-and-nginx-on-ubuntu-18-04

# adduser brett

# usermod -aG sudo brett

# su brett

# cd ~

# git clone https://github.com/brettvanderwerff/Portfolio-Website

# cd Portfolio-Website

# cd production_setup

# sudo bash production_setup.sh

apt-get update

apt-get install python3-pip python3-dev nginx

pip3 install virtualenv

cd ~

cd Portfolio-Website

virtualenv env

source env/bin/activate

pip3 install gunicorn

pip3 install -r requirements.txt

cp /home/brett/Portfolio-Website/production_setup/Portfolio-Website.service \
/etc/systemd/system/Portfolio-Website.service

systemctl start Portfolio-Website

systemctl enable Portfolio-Website

cp /home/brett/Portfolio-Website/production_setup/Portfolio-Website \
/etc/nginx/sites-available/Portfolio-Website

ln -s /etc/nginx/sites-available/Portfolio-Website /etc/nginx/sites-enabled

nginx -t

systemctl restart nginx

ufw delete allow 5000

ufw allow 'Nginx Full'