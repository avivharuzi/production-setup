#!/bin/bash

source colors.sh

function startScript() {
    info $TYPE_BACKGROUND "Running script $(basename $1)"
}

function startAction() {
    info $TYPE_BACKGROUND "Starting: $1"
}

function endAction() {
    success $TYPE_BACKGROUND "Done: $1"
}

function addSudoUser() {
    startAction "adding sudo user"

    read -p "Enter your user: " USER
    sudo adduser $USER
    sudo usermod -aG sudo $USER

    endAction "adding sudo user $USER"
}

function systemUpdates() {
    startAction "system updates"

    sudo apt-get update
    sudo apt-get upgrade

    endAction "system updates"
}

function basicSystemInstalls() {
    sudo apt-get install -y yum
    sudo apt-get install -y curl
    sudo apt-get install -y git
}

function installNginx() {
    startAction "installing nginx"

    sudo apt-get install nginx
    sudo ufw allow 'Nginx Full'

    endAction "nginx added successfully"
}

function installNodeJs() {
    startAction "installing node.js"

    sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
    sudo apt-get install -y nodejs
    sudo apt-get install -y build-essential

    sudo npm i -g npm nodemon pm2

    endAction "node.js added successfully"
}

function installMySql() {
    startAction "installing mysql"

    sudo apt-get install -y mysql-server

    endAction "mysql addedd successfully"
}

function mongodService() {
    startAction "mongod service"

    echo "mongodb-org hold" | sudo dpkg --set-selections
	echo "mongodb-org-server hold" | sudo dpkg --set-selections
	echo "mongodb-org-shell hold" | sudo dpkg --set-selections
	echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
	echo "mongodb-org-tools hold" | sudo dpkg --set-selections
	sudo service mongod start
	sudo mongo --host 127.0.0.1:27017

    endAction "mongod service"
}

function installMongoDb() {
    startAction "installing mongodb"

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
                    mongodService
                    break            
                    ;;
                "4.0")
                    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
                    echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
                    sudo apt-get update
                    sudo apt-get install -y mongodb-org=4.0.1 mongodb-org-server=4.0.1 mongodb-org-shell=4.0.1 mongodb-org-mongos=4.0.1 mongodb-org-tools=4.0.1
                    mongodService
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

    endAction "mongodb added successfully"
}

function installGhostBlog() {
    startAction "installing ghost cli"

    sudo npm i -g ghost-cli

    endAction "ghost cli added successfully"

    startAction "install ghost blog"

    sudo mkdir -p /var/www/ghost
    sudo chown $1:$1 /var/www/ghost
    sudo chmod 775 /var/www/ghost
    cd /var/www/ghost
    ghost install

    endAction "ghost blog added successfully"
}
