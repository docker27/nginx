#!/bin/bash

docker rm -f nginx_lastest
docker rmi qianchun27/nginx:lastest
docker build -t qianchun27/nginx:lastest -f Dockerfile .
docker run --privileged -t -d -p 80:80 --name nginx_lastest qianchun27/nginx:lastest /usr/sbin/init;
docker network connect wind_net nginx_lastest
docker exec -it nginx_lastest /bin/bash
