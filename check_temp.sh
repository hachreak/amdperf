#!/bin/sh

while [ `./get_temp.sh` -lt 85 ]; do
  echo "Temperature `./get_temp.sh`"
  sleep 1
done

echo "Reset fun speed"
./set_fun.sh auto
