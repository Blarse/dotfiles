#!/bin/bash

~/.scripts/wm_startup.sh

while true; do
	xsetroot -name "$($HOME/.scripts/statusbar.sh)"
	sleep 2
done &1

while true; do
	dwm 2> ~/.log/dwm.log
done
