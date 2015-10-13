#!/bin/sh

mkdir -p config/lib
zonefile -g zonefile.json > config/lib/zone
