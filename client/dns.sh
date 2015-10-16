#!/bin/sh

ssh -M -S ssh.socket -fnNT -L 53462:localhost:53462 root@localhost -p2422

node client.js $1 $2

ssh -S ssh.socket -O exit root@localhost -p2422 

