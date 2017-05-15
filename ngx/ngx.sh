cd ~

mkdir work || { echo work dir exists; }
cd work

cp -r ~/work/docker_git/ngx/ngx_conf ~/work/ngx_conf
cp -r ~/work/docker_git/ngx/ngx_demo ~/work/ngx_demo


docker stop ngx;
docker rm ngx;

docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/work/ngx_log:/var/log/nginx \
-v ~/work/ngx_conf:/etc/nginx/conf.d \
-v ~/work/ngx_demo:/www \
-p 80:80 \
--name ngx -d nginx