#!/bin/sh

sudo sh -c "echo $1 > /sys/class/drm/card1/device/pp_dpm_sclk"
