#!/bin/sh
v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=1
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=3