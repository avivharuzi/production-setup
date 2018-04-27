# Production Setup For Ubuntu 16.04

## Nginx

> Installation

``` sh
sudo apt-get update

sudo apt-get install nginx
```

> Adjust the Firewall

``` sh
sudo ufw app list

sudo ufw allow 'Nginx Full'

sudo ufw status

systemctl status nginx
```

## Node.js

``` sh
curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

sudo apt-get install -y nodejs

sudo apt-get install -y build-essential

node -v

npm -v

npm i -g npm

npm i -g nodemon

npm i -g pm2
```

## Start Test App

``` sh
cd ~ && cd ../home && vi hello.js
```

``` js
var http = require('http');
http.createServer(function (req, res) {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('Hello World\n');
}).listen(8080, 127.0.0.1);
console.log('Server running at http://127.0.0.1:8080/');
```

``` sh
nodemon hello.js
```
