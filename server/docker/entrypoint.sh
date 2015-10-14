#!/bin/bash
set -e

BIND_DATA_DIR=${CONFIG_DIR}

create_bind_data_dir() {
  echo "CREATE BIND DATA DIR"
  mkdir -p ${BIND_DATA_DIR}
  chmod -R 0755 ${BIND_DATA_DIR}
  chown -R root:${BIND_USER} ${BIND_DATA_DIR}

  # populate default bind configuration if it does not exist
  if [ -d ${BIND_DATA_DIR}/etc ]; then
      if [ ! -f ${BIND_DATA_DIR}/etc/rndc.key ]; then
          mv /etc/bind/rndc.key ${BIND_DATA_DIR}/etc/
      fi
  else
    mv /etc/bind ${BIND_DATA_DIR}/etc
  fi

  rm -rf /etc/bind
  ln -sf ${BIND_DATA_DIR}/etc /etc/bind

  if [ ! -d ${BIND_DATA_DIR}/lib ]; then
    mkdir -p ${BIND_DATA_DIR}/lib
    chown root:${BIND_USER} ${BIND_DATA_DIR}/lib
  fi
  rm -rf /var/lib/bind
  ln -sf ${BIND_DATA_DIR}/lib /var/lib/bind
}

create_pid_dir() {
  mkdir -m 0775 -p /var/run/named
  chown root:${BIND_USER} /var/run/named
}

create_pid_dir
create_bind_data_dir

if [ "$1" = 'named' ]; then
  echo "Starting named..."
  exec "$@" -u ${BIND_USER} -g
else
  exec "$@"
fi
