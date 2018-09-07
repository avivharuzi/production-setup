#!/bin/bash

# System Updates
sudo apt-get update

# Basic Installs - yum, curl, git
sudo apt-get install -y yum
sudo apt-get install -y curl
sudo apt-get install -y git

# Install Nginx
sudo apt-get install -y nginx
sudo ufw allow "Nginx Full"

# Install Node.js
sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential

# Install npm, nodemon, pm2
sudo npm i -g npm nodemon pm2

# Install MongoDB
PS3="Please choose MongoDB version: "
options=("3.6" "4.0" "Quit")
select opt in "${options[@]}"
    do
        case $opt in
            "3.6")
                sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
                echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
                sudo apt-get update
                sudo apt-get install -y mongodb-org=3.6.4 mongodb-org-server=3.6.4 mongodb-org-shell=3.6.4 mongodb-org-mongos=3.6.4 mongodb-org-tools=3.6.4
                break            
                ;;
            "4.0")
                sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
                echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
                sudo apt-get update
                sudo apt-get install -y mongodb-org=4.0.1 mongodb-org-server=4.0.1 mongodb-org-shell=4.0.1 mongodb-org-mongos=4.0.1 mongodb-org-tools=4.0.1
                break            
                ;;
            "Quit")
                break
                ;;
            *)
                echo "Invalid option $REPLY"
                ;;
        esac
done

# Mognod Service
echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
sudo service mongod start
sudo mongo --host 127.0.0.1:27017
