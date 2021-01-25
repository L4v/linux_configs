#! /bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# NOTE(Jovan): Get i3 workspace names
sh generate-ws-icon-list.sh
# Launch Polybar, using default config location ~/.confi/polybar/config
polybar mainbar -r &
echo "Polybar launched..."
