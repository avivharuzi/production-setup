# Production Setup For CentOS 7

## Nginx

> Installation

``` sh
sudo yum install epel-release

sudo yum install nginx

sudo systemctl start nginx

sudo systemctl enable nginx
```

> Adjust The Firewall

``` sh
sudo firewall-cmd --permanent --zone=public --add-service=http 
sudo firewall-cmd --permanent --zone=public --add-service=https
sudo firewall-cmd --reload
```

## Node.js

``` sh
sudo yum install git

curl --silent --location https://rpm.nodesource.com/setup_9.x | sudo bash -

sudo yum -y install nodejs

sudo yum install gcc-c++ make

node -v

npm -v

npm i -g npm

npm i -g nodemon

npm i -g pm2
```

## MongoDB

### Installation Of MongoDB

``` sh
sudo vi /etc/yum.repos.d/mongodb-org.repo
```

``` txt
[mongodb-org-3.6]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.6/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.6.asc
```

``` sh
sudo yum install -y mongodb-org

sudo yum install -y mongodb-org-3.6.4 mongodb-org-server-3.6.4 mongodb-org-shell-3.6.4 mongodb-org-mongos-3.6.4 mongodb-org-tools-3.6.4
```

### Mognod Service

``` sh
sudo systemctl start mongod

sudo systemctl reload mongod

sudo systemctl stop mongod

sudo service mongod restart

mongo --host 127.0.0.1:27017

sudo tail /var/log/mongodb/mongod.log

systemctl is-enabled mongod; echo $?

sudo systemctl enable mongod
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

``` sh
nodemon hello.js
```

## Using PM2

``` sh
pm2 start hello.js

pm2 startup systemd
```

## Setup Nginx With Node.js

``` sh
sudo vi /etc/nginx/nginx.conf
```

> nginx.conf

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
sudo yum install epel-release

sudo apt-get update

sudo yum install certbot-nginx
```

### Integrate With Nginx

``` sh
sudo vi /etc/nginx/nginx.conf
```

> nginx.conf

``` txt
. . .
server_name example.com www.example.com;
. . .
```

``` sh
sudo nginx -t

sudo systemctl reload nginx
```

``` sh
sudo iptables -I INPUT -p tcp -m tcp --dport 80 -j ACCEPT

sudo iptables -I INPUT -p tcp -m tcp --dport 443 -j ACCEPT
```

### Obtaining An SSL Certificate

``` sh
sudo certbot --nginx -d example.com -d www.example.com

sudo openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
```

``` sh
sudo vi /etc/nginx/nginx.conf
```

> nginx.conf

``` txt
. . .
server {
    ssl_dhparam /etc/ssl/certs/dhparam.pem;
}
```

``` sh
sudo nginx -t

sudo systemctl reload nginx

sudo crontab -e
```

> crontab

``` txt
. . .
15 3 * * * /usr/bin/certbot renew --quiet
```

## Redirect www To Non-www And Viceversa

``` sh
sudo vi /etc/nginx/conf.d/redirect.conf
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
sudo systemctl restart nginx

curl -I http://example.com
```
