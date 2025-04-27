#!/bin/sh
# v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=1 # Enables the auto focus # OLDER CONTROL COMMAND
v4l2-ctl -d /dev/video0 --set-ctrl=focus_automatic_continuous=1 # Enables the auto focus
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=3