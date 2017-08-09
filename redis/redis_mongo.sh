docker rm -f redis;
docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-p 8300:6379 \
--name redis -d redis:3.2.8

docker rm -f mongodb;
docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/data/db:/data/db \
-v ~/work/docker_git/redis/pictureAir:/src \
-p 8827:27017 \
--name mongodb -d mongo:3.2

docker exec mongodb /bin/bash -c 'mongorestore -d pictureAir --dir /src';