#!/bin/bash
set -e
sudo apt-get update
sleep 5s
echo 'Updated'
sudo apt-get install -y curl openssh-server ca-certificates tzdata perl ufw
echo 'Installed'
sudo debconf-set-selections <<< "postfix postfix/mailname string your.hostname.com"
sudo debconf-set-selections <<< "postfix postfix/main_mailer_type string 'Internet Site'"
sudo apt-get install -y postfix
echo 'Postfix'
sudo curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.deb.sh | sudo bash
echo 'curl'
sudo apt-get install gitlab-ce
echo 'gitlab'
sudo ufw allow http
sudo ufw allow https
sudo ufw allow OpenSSH
echo 'ufw'
export PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
sudo sed -i "s/http:\/\/gitlab.example.com/http:\/\/$PUBLIC_IP/" /etc/gitlab/gitlab.rb
sudo cat /etc/gitlab/gitlab.rb
sudo gitlab-ctl reconfigure

