#!/usr/bin/env bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Sends a notification when battery is full or very low.
# Icons are from Pop [`pop-icon-theme` on Arch]
# Cronjob is
#    */2 * * * * DISPLAY=:0 DBUS_SESSION_ADDRESS=unix:path=/run/user/1000/bus $HOME/bin/check_battery.sh

acpi -b | awk -F'[,:%]' '{print $2, $3}' | {
    read -r status capacity

    if [ "$status" = Discharging -a "$capacity" -lt 15 ]; then
        logger "Critical battery threshold met!"
        notify-send -c device -u critical "Low Battery" "Battery at $capacity%" --icon=battery-level-0-symbolic
    elif [ "$status" = Charging -a "$capacity" -gt 99 ]; then
        logger "Full battery threshold met!"
        notify-send -c device -u critical "Battery Charged" --icon=battery-level-100-symbolic
    fi
}
