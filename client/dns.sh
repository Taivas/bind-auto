#!/bin/sh

sslocal -c shadowsocks.json &
pid=$!
node client.js $1 $2
kill $pid

