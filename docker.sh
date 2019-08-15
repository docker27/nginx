#!/bin/bash

docker rm -f nginx
docker rmi qianchun27/nginx:1.13.12
docker build -t qianchun27/nginx:1.13.12 -f Dockerfile .
docker run --privileged -t -d -p 80:80 --name nginx qianchun27/nginx:1.13.12 /usr/sbin/init;
docker network connect wind_net nginx
docker exec -it nginx /bin/bash
