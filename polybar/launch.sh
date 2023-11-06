#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch one bar per monitor
for m in $(polybar --list-monitors | cut -d":" -f1); do
  if [ $m == 'HDMI-2' ]; then
    echo "---" | tee -a /tmp/polybar_mainbar_$m.log
    MONITOR=$m polybar --reload mainbar 2>&1 | tee -a /tmp/polybar_mainbar_$m.log & disown
  else
    echo "---" | tee -a /tmp/polybar_sidebar_$m.log
    MONITOR=$m polybar --reload sidebar 2>&1 | tee -a /tmp/polybar_sidebar_$m.log & disown
  fi
done
