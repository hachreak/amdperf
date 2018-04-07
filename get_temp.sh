#!/bin/sh

sudo cat /sys/kernel/debug/dri/1/amdgpu_pm_info | grep "GPU Temp" | awk '{print $3}'
