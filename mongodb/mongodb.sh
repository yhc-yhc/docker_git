rm -rf /data/mongodb/cs/rs1 || echo init to clear space
docker ps | grep mongo | awk '{print $1}' | xargs docker stop | xargs docker rm
docker-compose up -d
