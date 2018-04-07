#!/bin/sh

if [ "$1" = "auto" ]; then
  echo "set [auto]"
  sudo sh -c "echo 2 > /sys/class/drm/card1/device/hwmon/hwmon3/pwm1_enable"
else
  echo "set $1"
  sudo sh -c "echo $1 > /sys/class/drm/card1/device/hwmon/hwmon3/pwm1"
fi
