#!/bin/sh

sudo cat /sys/kernel/debug/dri/1/amdgpu_pm_info|grep average|awk '{print $1}'
