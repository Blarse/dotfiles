#!/bin/bash

# Daemons
#syndaemon -K -i 0.8 -R -d -t &
#pasystray &
#volumeicon &
nm-applet &
blueman-applet &
picom &
xss-lock slock &

autorandr --match-edid --change &

# Apps
#thunderbird &
firefox &
kitty &
