#!/bin/bash

while true; do
	if test "$(cat /sys/class/power_supply/BAT1/capacity)" -lt 10;
	then
		notify-send "Battery level is below 10  "
		swaynag "Battery low" -m "Battery level is below 10"
	fi
	if test "$(cat /sys/class/power_supply/BAT1/capacity)" -gt 95;
	then
		notify-send "Battery level has crossed 95  "
		swaynag "Battery high" -m "Battery level has crossed 95"
	fi
	sleep 30
done
