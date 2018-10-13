#!/bin/bash

source functions.sh

startScript $BASH_SOURCE

# System Updates
systemUpdates

# Basic System Installs
basicSystemInstalls

# Install Nginx
installNginx

# Install Node.js
installNodeJs

# Install MongoDB
installMongoDb
