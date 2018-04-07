#!/bin/sh

FUN_MODE=`cat /sys/class/drm/card1/device/hwmon/hwmon3/pwm1_enable`

[ $FUN_MODE -eq 2 ]
