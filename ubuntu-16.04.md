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

## Using PM2

``` sh
pm2 start hello.js

pm2 startup systemd
```

## Setup Nginx With Node.js

``` sh
sudo vi /etc/nginx/sites-available/defaul
```

> /etc/nginx/sites-available/default

``` txt
. . .
    location / {
        proxy_pass http://127.0.0.1:8080;
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

> /etc/nginx/sites-available/default

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
