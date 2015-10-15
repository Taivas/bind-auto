#!/bin/sh

cd docker
docker-compose up --force-recreate -d

cat $HOME/.ssh/authorized_keys | docker exec -i `docker-compose ps -q` /bin/sh -c 'cat > /root/.ssh/authorized_keys'
docker exec -i `docker-compose ps -q` /bin/sh -c 'chmod 600 /root/.ssh/authorized_keys'

