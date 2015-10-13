#!/bin/sh

docker exec -it `docker-compose ps -q` rndc reload

