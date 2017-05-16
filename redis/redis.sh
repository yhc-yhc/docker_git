docker run \
--privileged=true -v /etc/localtime:/etc/localtime \
-p 830:6379 \
--name redis -d redis:3.2.8