# Nginx Docker Image

Deploy Nginx with some global preset SSL rules.
A strong DHE parameter is also generated automatically during the first startup.

## SSL Support

The SSL cipher configuration is based on [mozillas recommendation](https://wiki.mozilla.org/Security/Server_Side_TLS) which should provide compatibility with clients back to Firefox 1, Chrome 1, IE 7, Opera 5, Safari 1, Windows XP IE8, Android 2.3, Java 7. The configuration also enables HSTS, and SSL session caches.

## Volumes

- `/etc/nginx/conf.d`: Virtual hist directory
- `/etc/nginx/certs`: Directory to place certificates
- `/var/log/nginx`: Nginx logs

## Systemd service

```
[Unit]
Description=Dockerized Nginx
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStartPre=-/usr/bin/docker kill nginx
ExecStartPre=-/usr/bin/docker rm nginx
ExecStartPre=/usr/bin/docker pull nginx
ExecStart=/usr/bin/docker run --name=nginx \
  -p 80:80 -p 443:443 \
  -v /some/path/conf.d:/etc/nginx/conf.d:ro \
  -v /some/path/certs:/etc/nginx/certs:ro \
  -v /some/path/log:/var/log/nginx \
  nginx

[Install]
Alias=nginx.service
WantedBy=multi-user.target
```

Mount the `/etc/nginx/certs` in read-write mode during the first startup. Otherwise the automatic DHE parameter generation will fail.