#!/bin/bash

# Daemons
#syndaemon -K -i 0.8 -R -d -t &
nm-applet &
blueman-applet &
#pasystray &
volumeicon &
picom &
xss-lock slock &

autorandr --match-edid --change &

# Apps
#thunderbird &
firefox &
kitty &
