# Production Setup For Ubuntu 16.04

## Nginx

> Installation

```bash
    sudo apt-get update

    sudo apt-get install nginx
```

> Adjust the Firewall

```bash
    sudo ufw app list

    sudo ufw allow 'Nginx Full'
    
    sudo ufw status
    
    systemctl status nginx
```
