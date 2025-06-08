#!/bin/bash

MONITOR_COUNT=$(xrandr | grep " connected" | wc -l)

if [ $MONITOR_COUNT -eq 2 ]; then
    # Get both monitors
    MONITORS=($(xrandr | grep " connected" | cut -d" " -f1))
    MONITOR1=${MONITORS[0]}
    MONITOR2=${MONITORS[1]}
    
    # Check if both monitors are currently active
    ACTIVE_COUNT=$(xrandr | grep " connected" | grep -c " [0-9]")
    
    if [ $ACTIVE_COUNT -eq 2 ]; then
        # Currently dual, switch to single
        # Turn off the SECONDARY monitor, keep the primary
        PRIMARY=$(xrandr | grep " connected primary" | cut -d" " -f1)
        
        if [ -z "$PRIMARY" ]; then
            # No primary set, use first monitor as primary
            PRIMARY=$MONITOR1
        fi
        
        # Turn off the non-primary monitor
        if [ "$PRIMARY" = "$MONITOR1" ]; then
            SECONDARY=$MONITOR2
        else
            SECONDARY=$MONITOR1
        fi
        
        echo "Turning off $SECONDARY, keeping $PRIMARY"
        xrandr --output "$SECONDARY" --off --output "$PRIMARY" --auto --primary
        
        # Set wallpaper
        feh --bg-fill --randomize ~/repos/.dotfiles/wallpapers/*
        notify-send "Monitor" "Switched to single monitor ($PRIMARY)"
        
    else
        # Currently single, switch to dual
        echo "Switching to dual monitor setup"
        ~/repos/.dotfiles/scripts/monitor-setup.sh
        notify-send "Monitor" "Switched to dual monitors"
    fi
else
    notify-send "Monitor" "Only one monitor detected"
fi
