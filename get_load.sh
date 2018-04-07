#!/bin/sh

sudo cat /sys/kernel/debug/dri/1/amdgpu_pm_info | grep "GPU Load" | awk '{print $3}'
