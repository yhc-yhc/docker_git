### 免 sudo 使用 docker

	sudo groupadd docker 如果还没有 docker group 就添加一个：
	sudo gpasswd -a ${USER} docker  将用户加入该 group 内。然后退出并重新登录就生效啦。
	sudo service docker restart   重启 docker 服务
	newgrp - docker || pkill X  切换当前会话到新 group 或者重启 X 会话

### 升级 docker 
	docker -v   # if the version lt 1.8, cannot use daocloud
	sudo service stop docker
	sudo wget https://get.docker.com/builds/Linux/x86_64/docker-1.9.1
	mv /usr/bin/docker /usr/bin/docker_bak
	mv docker-1.9.1 /usr/bin/docker
	chmod +x /usr/bin/docker
	/etc/init.d/docker start
	service docker start
	docker -v

### docker 加速器
	curl -sSL https://get.daocloud.io/daotools/set_mirror.sh | sh -s http://0c19a7ee.m.daocloud.io

### docker 维护
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker stop
	docker ps -a | grep "Exited" | awk '{print $1 }'|xargs docker rm
	docker images -a | grep none | awk '{print $3 }'|xargs docker rmi

#stop all container
	docker ps | grep "Up" | awk '{print $1 }' | xargs docker stop | xargs docker rm
	docker ps -a | grep Exited | awk '{print $1 }' | xargs docker rm

###docker run --help

	Usage:	docker run [OPTIONS] IMAGE [COMMAND] [ARG...]

	Run a command in a new container

	  -a, --attach=[]                 Attach to STDIN, STDOUT or STDERR
	  --add-host=[]                   Add a custom host-to-IP mapping (host:ip)
	  --blkio-weight=0                Block IO (relative weight), between 10 and 1000
	  --cpu-shares=0                  CPU shares (relative weight)
	  --cap-add=[]                    Add Linux capabilities
	  --cap-drop=[]                   Drop Linux capabilities
	  --cgroup-parent=                Optional parent cgroup for the container
	  --cidfile=                      Write the container ID to the file
	  --cpu-period=0                  Limit CPU CFS (Completely Fair Scheduler) period
	  --cpu-quota=0                   Limit CPU CFS (Completely Fair Scheduler) quota
	  --cpuset-cpus=                  CPUs in which to allow execution (0-3, 0,1)
	  --cpuset-mems=                  MEMs in which to allow execution (0-3, 0,1)
	  -d, --detach=false              Run container in background and print container ID
	  --device=[]                     Add a host device to the container
	  --disable-content-trust=true    Skip image verification
	  --dns=[]                        Set custom DNS servers
	  --dns-opt=[]                    Set DNS options
	  --dns-search=[]                 Set custom DNS search domains
	  -e, --env=[]                    Set environment variables
	  --entrypoint=                   Overwrite the default ENTRYPOINT of the image
	  --env-file=[]                   Read in a file of environment variables
	  --expose=[]                     Expose a port or a range of ports
	  --group-add=[]                  Add additional groups to join
	  -h, --hostname=                 Container host name
	  --help=false                    Print usage
	  -i, --interactive=false         Keep STDIN open even if not attached
	  --ipc=                          IPC namespace to use
	  --kernel-memory=                Kernel memory limit
	  -l, --label=[]                  Set meta data on a container
	  --label-file=[]                 Read in a line delimited file of labels
	  --link=[]                       Add link to another container
	  --log-driver=                   Logging driver for container
	  --log-opt=[]                    Log driver options
	  --lxc-conf=[]                   Add custom lxc options
	  -m, --memory=                   Memory limit
	  --mac-address=                  Container MAC address (e.g. 92:d0:c6:0a:29:33)
	  --memory-reservation=           Memory soft limit
	  --memory-swap=                  Total memory (memory + swap), '-1' to disable swap
	  --memory-swappiness=-1          Tuning container memory swappiness (0 to 100)
	  --name=                         Assign a name to the container
	  --net=default                   Set the Network for the container
	  --oom-kill-disable=false        Disable OOM Killer
	  -P, --publish-all=false         Publish all exposed ports to random ports
	  -p, --publish=[]                Publish a container's port(s) to the host
	  --pid=                          PID namespace to use
	  --privileged=false              Give extended privileges to this container
	  --read-only=false               Mount the container's root filesystem as read only
	  --restart=no                    Restart policy to apply when a container exits
	  --rm=false                      Automatically remove the container when it exits
	  --security-opt=[]               Security Options
	  --sig-proxy=true                Proxy received signals to the process
	  --stop-signal=SIGTERM           Signal to stop a container, SIGTERM by default
	  -t, --tty=false                 Allocate a pseudo-TTY
	  -u, --user=                     Username or UID (format: <name|uid>[:<group|gid>])
	  --ulimit=[]                     Ulimit options
	  --uts=                          UTS namespace to use
	  -v, --volume=[]                 Bind mount a volume
	  --volume-driver=                Optional volume driver for the container
	  --volumes-from=[]               Mount volumes from the specified container(s)


### docker postgresql

	docker run --name pg -v /etc/localtime:/etc/localtime --privileged=true -e POSTGRES_PASSWORD=josh -v ~/pgdb:/var/lib/postgresql/data -d -p 2345:5432 postgres

#### 修改postgresql 密码
	docker exec -it pg /bin/bash
	su postgres
	psql -U postgres
	ALTER USER postgres WITH PASSWORD 'josh';
	\q
	exit
	exit

	docker run \
	-p 8080:8080 \
	-d --name jenkins  jenkins


### docker mongo

	docker run -d --name temp -v ~/mongodata/pictureAir:/data/db --privileged=true mongo:3.2

	docker exec -it temp /bin/bash

	/usr/bin/mongorestore -d pictureAir /data/db 

	=============================

	export node1="192.168.8.114"
	export node2="192.168.8.115"
	export node3="192.168.8.116"

	docker run \
	--privileged=true -v /etc/localtime:/etc/localtime \
	-v ~/mongodata/pictureAir:/data/db \
	-p 27017:27017 \
	--hostname="mongo_116" \
	--add-host mongo_114:${node1} \
	--add-host mongo_115:${node2} \
	--add-host mongo_116:${node3} \
	--name mongo -d mongo:3.2 \
	--storageEngine wiredTiger \
	--smallfiles \
	--replSet "rs0"

	docker exec -it mongo /bin/bash
	mongo
	use admin

	docker run \
	--privileged=true -v /etc/localtime:/etc/localtime \
	-v ~/mongodata/slaver:/data/db \
	-p 27017:27017 \
	--hostname="mongo_115" \
	--add-host mongo_114:${node1} \
	--add-host mongo_115:${node2} \
	--add-host mongo_116:${node3} \
	--name mongo -d mongo:3.2 \
	--storageEngine wiredTiger \
	--smallfiles \
	--replSet "rs0"

### use docker-compose

	curl -L https://github.com/docker/compose/releases/download/1.8.1/docker-compose-Linux-x86_64 > /usr/bin/docker-compose
	
	chmod  +x /usr/bin/docker-compose

cat ~/.ssh/id_rsa.pub | pbcopy

### centos7 run after start
	[Unit]
	Requires=docker.service
	After=docker.service

	[Service]
	Type=forking
	ExecStart=/etc/systemd/system/PWApps.sh

	[Install]
	WantedBy=multi-user.target