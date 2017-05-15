

创建副本集1 

docker run --name rs1_srv1 -p 21117:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs1

docker run --name rs1_srv2 -p 21217:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs1

docker run --name rs1_srv3 -p 21317:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs1




创建副本集2 

docker run --name rs2_srv1 -p 22117:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs2

docker run --name rs2_srv2 -p 22217:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs2

docker run --name rs2_srv3 -p 22317:27017 -d mongo:3.2 --shardsvr --port 27017 --noprealloc --smallfiles --replSet rs2




创建配置容器

docker run --name cfg1 -p 20117:27017 -d mongo:3.2 --noprealloc --smallfiles --configsvr  --dbpath /data/db --port 27017

docker run --name cfg2 -p 20217:27017 -d mongo:3.2 --noprealloc --smallfiles --configsvr  --dbpath /data/db --port 27017

docker run --name cfg3 -p 20317:27017 -d mongo:3.2 --noprealloc --smallfiles --configsvr  --dbpath /data/db --port 27017



创建mongo router

docker run --name mongos_router -p 27017:27017 -d mongo:3.2 --configdb 192.168.8.58:20117,192.168.8.58:20217,192.168.8.58:20317 --port 27017


 配置副本集1

 //连接到rs1_svr1
mongo 192.168.8.58:21117
//配置副本集
rs.initiate();
rs.add("192.168.8.58:21217");
rs.add("192.168.8.58:21317");
rs.status();
Fix hostname of primary.
cfg = rs.conf();
cfg.members[0].host = "192.168.8.58:21117";
rs.reconfig(cfg);
rs.status();
//以上命令一个一个执行



配置副本集2


//连接到rs2_svr1
mongo 192.168.8.58:22117
//配置副本集
rs.initiate();
rs.add("192.168.8.58:22217");
rs.add("192.168.8.58:22317");
rs.status();
Fix hostname of primary.
cfg = rs.conf();
cfg.members[0].host = "192.168.8.58:22117";
rs.reconfig(cfg);
rs.status();
//以上命令一个一个执行


配置分片

//连接到路由服务器
mongo 192.168.8.58:27017

sh.addShard("rs1/192.168.8.58:27017");
sh.addShard("rs2/192.168.8.58:27017");
sh.status();



创建用户

use admin

db.createUser({user:'superadmin',pwd:'123456', roles:[{role:'root', db:'admin'}]})

db.auth('superadmin', '123456')

