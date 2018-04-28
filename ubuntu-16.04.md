# Production Setup For Ubuntu 16.04

## Nginx

> Installation

``` sh
sudo apt-get update

sudo apt-get install nginx
```

> Adjust The Firewall

``` sh
sudo ufw app list

sudo ufw allow 'Nginx Full'

sudo ufw status

systemctl status nginx
```

## Node.js

``` sh
sudo yum install git

curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -

sudo apt-get install -y nodejs

sudo apt-get install -y build-essential

npm i -g npm nodemon pm2
```

## MongoDB

### Installation Of MongoDB

``` sh
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

sudo apt-get update

sudo apt-get install -y mongodb-org

sudo apt-get install -y mongodb-org=3.6.4 mongodb-org-server=3.6.4 mongodb-org-shell=3.6.4 mongodb-org-mongos=3.6.4 mongodb-org-tools=3.6.4

echo "mongodb-org hold" | sudo dpkg --set-selections
echo "mongodb-org-server hold" | sudo dpkg --set-selections
echo "mongodb-org-shell hold" | sudo dpkg --set-selections
echo "mongodb-org-mongos hold" | sudo dpkg --set-selections
echo "mongodb-org-tools hold" | sudo dpkg --set-selections
```

### Mognod Service

``` sh
sudo service mongod start

sudo service mongod stop

sudo service mongod restart

mongo --host 127.0.0.1:27017
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
}).listen(8080, APP_PRIVATE_IP_ADDRESS);
console.log('Server running at http://APP_PRIVATE_IP_ADDRESS:8080');
```

## Using PM2

``` sh
pm2 start hello.js

pm2 startup systemd
```

## Setup Nginx With Node.js

``` sh
sudo vi /etc/nginx/sites-available/default
```

> default

``` txt
. . .
    location / {
        proxy_pass http://APP_PRIVATE_IP_ADDRESS:8080;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host $host;
        proxy_cache_bypass $http_upgrade;
    }
}
```

``` sh
sudo nginx -t

sudo systemctl restart nginx
```

## SSL Certficate With Lets Encrypt

``` sh
sudo add-apt-repository ppa:certbot/certbot

sudo apt-get update

sudo apt-get install python-certbot-nginx
```

### Integrate With Nginx

``` sh
sudo vi /etc/nginx/sites-available/default
```

> default

``` txt
. . .
server_name example.com www.example.com;
. . .
```

``` sh
sudo nginx -t

sudo systemctl reload nginx
```

### Obtaining An SSL Certificate

``` sh
sudo certbot --nginx -d example.com -d www.example.com

sudo certbot renew --dry-run
```

## Redirect www To Non-www And Viceversa

``` sh
sudo vi /etc/nginx/sites-enabled/default
```

### Redirect www To non-www

``` txt
server {
    server_name www.example.com;
    return 301 $scheme://example.com$request_uri;
}
```

### Redirect non-www To www

``` txt
server {
    server_name example.com;
    return 301 $scheme://www.example.com$request_uri;
}
```

``` sh
sudo service nginx restart

curl -I http://example.com
```
