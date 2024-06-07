#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
# polybar-msg cmd quit
# Otherwise you can use the nuclear option:
killall -q polybar

sleep 0.5

if [[ $(xrandr --query | grep " connected" | wc -l) -eq 1 ]]; then
    # Code to execute if the number of lines is 1
    polybar --reload top &
    polybar --reload bottom &
else
    PRIMARY=$(xrandr --query | grep " connected" | grep "primary" | cut -d" " -f1)
    OTHERS=$(xrandr --query | grep " connected" | grep -v "primary" | cut -d" " -f1)

    MONITOR=$PRIMARY polybar --reload top &
    MONITOR=$PRIMARY polybar --reload bottom &

    sleep 0.5

    for m in $OTHERS; do
        MONITOR=$m polybar --reload top &
        MONITOR=$m polybar --reload bottom &
    done
fi

echo "Bars launched..."
