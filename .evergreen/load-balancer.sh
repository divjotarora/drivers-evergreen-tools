#!/bin/sh

set -o errexit  # Exit the script with error if any of the commands fail

start() {
  echo "Starting HAProxy..."

  cat <<EOF_HAPROXY_CONFIG >> $DRIVERS_TOOLS/haproxy.conf
  defaults
      mode tcp
      timeout connect 5000ms
      timeout client 5000ms
      timeout server 5000ms

  frontend mongos_frontend
      bind *:8000
      use_backend mongos_backend

  frontend mongoses_frontend
      bind *:8001
      use_backend mongoses_backend

  backend mongos_backend
      mode tcp
      server mongos 127.0.0.1:27017 check

  backend mongoses_backend
      mode tcp
      server mongos_one 127.0.0.1:27017 check
      server mongos_two 127.0.0.1:27018 check
EOF_HAPROXY_CONFIG

  cat $DRIVERS_TOOLS/haproxy.conf

  /usr/sbin/haproxy -D -f $DRIVERS_TOOLS/haproxy.conf -p ./haproxy.pid

  ADDRESS=$(curl -s http://169.254.169.254/latest/meta-data/public-hostname)
  SINGLE_MONGOS_LB_URI="$ADDRESS:8000"
  MULTI_MONGOS_LB_URI="$ADDRESS:8001"

  echo "Single Mongos LB: $SINGLE_MONGOS_LB_URI"
  echo "Multiple Mongos LB: $MULTI_MONGOS_LB_URI"

  export SINGLE_MONGOS_LB_URI="$SINGLE_MONGOS_LB_URI"
  export MULTI_MONGOS_LB_URI="$MULTI_MONGOS_LB_URI"
}

stop() {
  echo "Stopping HAProxy..."
  kill -USR1 $(cat $DRIVERS_TOOLS/haproxy.pid)
  rm $DRIVERS_TOOLS/haproxy.conf $DRIVERS_TOOLS/haproxy.pid
}

case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  *)
    echo "Usage: load-balancer.sh (start|stop)"
    exit 1
esac
