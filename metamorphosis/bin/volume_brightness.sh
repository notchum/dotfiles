#!/usr/bin/env bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# My fork of https://gitlab.com/Nmoleo/i3-volume-brightness-indicator
#     Changes:
#     - `brightnessctl` for backlight control
#     - Pop icons
#     - Better volume notifications with more level icons
#     - Better brightness notifications with more level icons

bar_color="#95E6CB"
volume_step=1
brightness_step=5%
max_volume=100

# Uses regex to get volume from pactl
function get_volume {
    pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]{1,3}(?=%)' | head -1
}

# Uses regex to get mute status from pactl
function get_mute {
    pactl get-sink-mute @DEFAULT_SINK@ | grep -Po '(?<=Mute: )(yes|no)'
}

# Uses regex to get brightness from brightnessctl
function get_brightness {
    brightnessctl | grep -Po '\(([^)]+)\)' | sed 's/[()%]//g'
}

# Returns a mute icon or the appropriate volume-level icon
function get_volume_icon {
    volume=$(get_volume)
    mute=$(get_mute)
    if [ "$volume" -eq 0 ] || [ "$mute" == "yes" ] ; then
        volume_icon="audio-volume-muted-symbolic"
    elif [ "$volume" -gt 0  ] && [ "$volume" -le 35 ] ; then
        volume_icon="audio-volume-low-symbolic"
    elif [ "$volume" -gt 35 ] && [ "$volume" -le 85 ] ; then
        volume_icon="audio-volume-medium-symbolic"
    else
        volume_icon="audio-volume-high-symbolic"
    fi
}

# Returns the appropriate brightness-level icon
function get_brightness_icon {
    brightness=$(get_brightness)
    if [ "$brightness" -eq 0 ] ; then
        brightness_icon="display-brightness-off-symbolic"
    elif [ "$brightness" -gt 0  ] && [ "$brightness" -le 35 ] ; then
        brightness_icon="display-brightness-low-symbolic"
    elif [ "$brightness" -gt 35 ] && [ "$brightness" -le 85 ] ; then
        brightness_icon="display-brightness-medium-symbolic"
    else
        brightness_icon="display-brightness-high-symbolic"
    fi
}

# Displays a volume notification using dunstify
function show_volume_notif {
    mute=$(get_mute)
    get_volume_icon
    volume="$volume%"
    if [ "$mute" == "yes" ] ; then
        volume="Muted"
    fi
    dunstify -i $volume_icon -t 1000 -r 2593 -u normal "$volume" -h int:value:$volume -h string:hlcolor:$bar_color
}

# Displays a brightness notification using dunstify
function show_brightness_notif {
    brightness=$(get_brightness)
    get_brightness_icon
    dunstify -i $brightness_icon -t 1000 -r 2594 -u normal "$brightness%" -h int:value:$brightness -h string:hlcolor:$bar_color
}

# Main function - Takes user input, "volume_up", "volume_down", "brightness_up", or "brightness_down"
case $1 in
    volume_up)
    # Unmutes and increases volume, then displays the notification
    pactl set-sink-mute @DEFAULT_SINK@ 0
    volume=$(get_volume)
    if [ $(( "$volume" + "$volume_step" )) -gt $max_volume ]; then
        pactl set-sink-volume @DEFAULT_SINK@ $max_volume%
    else
        pactl set-sink-volume @DEFAULT_SINK@ +$volume_step%
    fi
    show_volume_notif
    ;;

    volume_down)
    # Raises volume and displays the notification
    pactl set-sink-volume @DEFAULT_SINK@ -$volume_step%
    show_volume_notif
    ;;

    volume_mute)
    # Toggles mute and displays the notification
    pactl set-sink-mute @DEFAULT_SINK@ toggle
    show_volume_notif
    ;;

    brightness_up)
    # Increases brightness and displays the notification
    brightnessctl set $brightness_step+
    show_brightness_notif
    ;;

    brightness_down)
    # Decreases brightness and displays the notification
    brightnessctl set $brightness_step-
    show_brightness_notif
    ;;
esac
