#!/bin/sh

PORT=23487

ssh -M -S ssh.socket -fnNT -L $PORT:localhost:53462 root@localhost -p2422

node client.js $PORT $1 $2

ssh -S ssh.socket -O exit root@localhost -p2422 

