#!/bin/bash
v4l2-ctl -d /dev/video0 --set-ctrl=focus_auto=0 # disables the auto focus
v4l2-ctl -d /dev/video0 --set-ctrl=focus_absolute=50 # sets the focus absolute value at 50 (tune this if image is blur)
v4l2-ctl -d /dev/video0 --set-ctrl=exposure_auto=3 # sets the xposure to aperture mode 