#!/bin/sh
# v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=1 # Enables the auto focus # OLDER CONTROL COMMAND
v4l2-ctl -d /dev/video0 --set-ctrl=focus_automatic_continuous=1 # Enables the auto focus
# v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=3 # sets the xposure to aperture mode # OLDER CONTROL COMMAND 
v4l2-ctl -d /dev/video0 --set-ctrl=auto_exposure=3 # sets the xposure to aperture mode
v4l2-ctl -d /dev/video0 --set-ctrl=backlight_compensation=1 # Turn it ON since the camera setup is near window
