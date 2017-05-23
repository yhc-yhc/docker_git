cd ~

mkdir work || { echo work dir exists; }
cd work

# cp -r ~/work/docker_git/ngx/ngx_conf ~/work/ngx_conf
# cp -r ~/work/docker_git/ngx/ngx_demo ~/work/ngx_demo

# rm -rf ngx_log

docker stop ngx;
docker rm ngx;

docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/work/ngx_log:/usr/local/openresty/nginx/logs \
-v ~/work/docker_git/ngx/ngix.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro  \
-v ~/work/docker_git/ngx/ngx_conf:/etc/nginx/conf.d \
-v ~/work/pictureAir/static:/www \
-p 80:80 \
--name ngx -d openresty/openresty

#!/usr/bin/env bash
# docker run -d --name="nginx" 
# -p 8080:80 
# -v $PWD/config/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro 
# -v $PWD/logs:/usr/local/openresty/nginx/logs 
# openresty/openresty:1.9.15.1-trusty


docker run -d --name ngx --net=host -v $PWD/config/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro openresty/openresty


docker run -d --name ngx -p 8080:80 --privileged=true -v ~/work/config/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro openresty/openresty