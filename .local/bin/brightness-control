#!/bin/bash

ACTION=$1
STEP=5

if [ "$ACTION" = "get" ]; then
    # Use waybar output name to determine the display number
    case "$WAYBAR_OUTPUT_NAME" in
        *"DP-1"*) DISPLAY_NUM=1 ;;
        *"HDMI-A-1"*) DISPLAY_NUM=2 ;;
        *) DISPLAY_NUM=1 ;;
    esac
else
    # When user is actively scrolling or clicking, use the cursor position to determine the display number
    CURSOR_X=$(hyprctl cursorpos | awk -F',' '{print $1}')
    if [[ -n "$CURSOR_X" ]] && [ "$CURSOR_X" -lt 0 ]; then
        DISPLAY_NUM=2
    else
        DISPLAY_NUM=1
    fi
fi

STATE_FILE="/tmp/waybar_brightness_display${DISPLAY_NUM}.tmp"

set_brightness_in_background() {
    pkill -f "ddcutil --display $DISPLAY_NUM setvcp 10"
    (ddcutil --display "$DISPLAY_NUM" setvcp 10 "$1") &
}

if [ ! -s "$STATE_FILE" ]; then
    initial_brightness=$(ddcutil --display "$DISPLAY_NUM" getvcp 10 -t 2>/dev/null | cut -d ' ' -f 4)

    if [ -z "$initial_brightness" ]; then
        initial_brightness=50 # Failsafe
    fi
    echo "$initial_brightness" > "$STATE_FILE"
fi

current=$(cat "$STATE_FILE")

if [ -z "$current" ]; then
    current=50
fi

case "$ACTION" in
    "get")
        echo " $current"
        ;;
    "up")
        new_brightness=$((current + STEP > 100 ? 100 : current + STEP))
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "down")
        new_brightness=$((current - STEP < 0 ? 0 : current - STEP))
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "right_click")
        new_brightness=0
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
    "left_click")
        new_brightness=100
        if [ "$current" -ne "$new_brightness" ]; then
            echo "$new_brightness" > "$STATE_FILE"
            set_brightness_in_background "$new_brightness"
        fi
        pkill -RTMIN+8 waybar
        ;;
esac
