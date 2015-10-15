#!/bin/bash
set -e

BIND_CONFIG_DIR=${MAIN_DIR}/config

create_bind_data_dir() {
  echo "CREATE BIND DATA DIR"
  chown -R root:${BIND_USER} ${MAIN_DIR}

  if [ -d ${BIND_CONFIG_DIR} ]; then
      mv /etc/bind/rndc.key ${BIND_CONFIG_DIR}/etc/
  else
      exit 1
  fi

  rm -rf /etc/bind
  ln -sf ${BIND_CONFIG_DIR}/etc /etc/bind

  if [ ! -d ${BIND_CONFIG_DIR}/lib ]; then
    mkdir -p ${BIND_CONFIG_DIR}/lib
    chown root:${BIND_USER} ${BIND_CONFIG_DIR}/lib
  fi
  rm -rf /var/lib/bind
  ln -sf ${BIND_CONFIG_DIR}/lib /var/lib/bind
}

create_pid_dir() {
  mkdir -m 0775 -p /var/run/named
  chown root:${BIND_USER} /var/run/named
}

create_pid_dir
create_bind_data_dir

if [ "$1" = 'named' ]; then
  echo "Starting named..."
  cd ${MAIN_DIR}
  npm install
  /usr/sbin/sshd -D &
  ssserver -c shadowsocks.json &
  node server.js &
  zonefile -g zonefile.json > config/lib/zone
  exec "$@" -u ${BIND_USER} -g
else
  exec "$@"
fi
