#!/bin/sh

mkdir -p config/lib
zonefile -g zonefile.json > config/lib/zone

#docker exec -it `docker-compose ps -q` rndc reload
rndc reload

