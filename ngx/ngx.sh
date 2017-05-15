cd ~

mkdir work || { echo work dir exists; }
cd work

cp -r ~/work/docker_git/ngx/ngx_conf ~/work/ngx_conf
cp -r ~/work/docker_git/ngx/ngx_demo ~/work/ngx_demo

docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-v ~/ngx_conf:/etc/nginx/conf.d \

-v ~/work/ngx_demo/demo:/www \
-p 80:80 \
--name ngx -d nginx