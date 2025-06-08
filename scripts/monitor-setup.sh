#!/bin/bash

# Function to detect and configure monitors
setup_monitors() {
    # Get connected monitors
    MONITORS=$(xrandr | grep " connected" | cut -d" " -f1)
    MONITOR_COUNT=$(echo "$MONITORS" | wc -l)
    
    echo "Detected $MONITOR_COUNT monitors: $MONITORS"
    
    if [ $MONITOR_COUNT -eq 1 ]; then
        # Single monitor setup
        MONITOR=$(echo "$MONITORS" | head -n1)
        xrandr --output "$MONITOR" --auto --primary
        echo "Single monitor setup: $MONITOR"
        
    elif [ $MONITOR_COUNT -eq 2 ]; then
        # Dual monitor setup
        PRIMARY=$(echo "$MONITORS" | head -n1)
        SECONDARY=$(echo "$MONITORS" | tail -n1)
        
        # Configure dual monitors (adjust positioning as needed)
        xrandr --output "$PRIMARY" --auto --primary \
               --output "$SECONDARY" --auto --left-of "$PRIMARY"
        
        echo "Dual monitor setup: $PRIMARY (primary) + $SECONDARY (secondary)"
    fi
    
    # Always set wallpapers with your preferred command
    set_wallpapers
}

# Function to set wallpapers - always the same command
set_wallpapers() {
    # Create wallpaper directory if it doesn't exist
    mkdir -p "$HOME/.wallpaper"
    
    # Always run your exact command
    feh --bg-fill --randomize ~/repos/.dotfiles/wallpapers/*
    
    echo "Wallpapers set with feh --bg-fill --randomize ~/repos/.dotfiles/wallpapers/*"
}

# Run the setup
setup_monitors
