#!/usr/bin/env sh

#Terminate already running polybar instances
killall -q polybar

#Wait
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

#Launch bars
polybar primary &

echo "Bars launched..."
