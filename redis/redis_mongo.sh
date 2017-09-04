docker network rm pictureair;
docker network create --subnet=172.18.0.0/16 pictureair;
docker rm -f redis;
docker run \
--net pictureair --ip 172.18.0.10 \
--privileged=true -v /etc/localtime:/etc/localtime \
-p 8300:6379 \
--name redis -d redis:3.2.8

docker rm -f mongodb;
docker run \
--net pictureair --ip 172.18.0.11 \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/data/db:/data/db \
-v ~/work/docker_git/redis/pictureAir:/src \
-p 8827:27017 \
--name mongodb -d mongo:3.2

docker exec mongodb /bin/bash -c 'mongorestore -d pictureAir --dir /src';