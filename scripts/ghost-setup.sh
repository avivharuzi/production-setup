#!/bin/bash

source functions.sh

startScript $BASH_SOURCE

# Add Sudo User
addSudoUser

# System Updates
systemUpdates

# Basic System Installs
basicSystemInstalls

# Install Nginx
installNginx

# Install Node.js
installNodeJs

# Install MySQL
installMySql

# Install Ghost Blog
read -p "Enter your user to use for ghost blog: " USER

installGhostBlog $USER
