rm -rf ~/data/mongodb || echo init to clear space
docker ps | grep mongo | awk '{print $1}' | xargs docker rm -f
docker-compose up -d
