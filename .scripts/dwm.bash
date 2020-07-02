#!/bin/bash

nitrogen --restore &
pavucontrol &
sxhkd &

while true; do
	xsetroot -name "$($HOME/.scripts/statusbar.bash)"
	sleep 2
done &1

while true; do
	dwm 2> ~/.log/.dwm.log
done
