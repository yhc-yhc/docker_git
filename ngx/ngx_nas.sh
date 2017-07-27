cd ~

mkdir work || { echo work dir exists; }
cd work

# cp -r ~/work/docker_git/ngx/ngx_conf ~/work/ngx_conf
# cp -r ~/work/docker_git/ngx/ngx_demo ~/work/ngx_demo

# rm -rf ngx_log

docker stop ngx || echo ngx container not exists;
docker rm ngx || echo ngx container not exists;

docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/work/ngx_log:/usr/local/openresty/nginx/logs \
-v ~/work/docker_git/ngx/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf:ro  \
-v ~/work/docker_git/ngx/ngx_conf/nas:/usr/local/openresty/nginx/conf/conf.d \
-v /photos:/www/photos \
-p 80:80 \
--name ngx -d openresty/openresty