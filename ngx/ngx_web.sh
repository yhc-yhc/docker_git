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
-v ~/work/docker_git/ngx/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro  \
-v ~/work/docker_git/ngx/ngx_conf/web:/usr/local/openresty/nginx/conf/conf.d \
-v ~/work/pictureAir/static:/www \
-p 80:80 \
--name ngx -d openresty/openresty