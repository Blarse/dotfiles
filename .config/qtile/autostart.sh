#!/bin/bash

# Config
monlayout.sh top
#xmodmap ~/.Xmodmap &
~/.fehbg

# Daemons
syndaemon -K -i 0.8 -R -d -t &
nm-applet &
blueman-applet &
#pasystray &
volumeicon &
picom &
xss-lock slock &

# Apps
#thunderbird &
firefox &
kitty &
