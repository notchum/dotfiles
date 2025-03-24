#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1 | grep "DP"); do
    MONITOR=$m polybar -rq bar &
  done
else
  polybar --reload mybar &
fi

echo "Polybar launched..."