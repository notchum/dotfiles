#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#
## Rofi   : Launcher (Modi Drun, Run, File Browser, Window)
#
## Fork   : Adapted for Sway; theme hardcoded

dir="$HOME/.config/rofi/launcher"

## Run
rofi \
    -show drun \
    -theme ${dir}/launcher.rasi \
    -show-icons \
    -icon-theme Pop \
    | xargs swaymsg exec --
# Note: pass rofi command to swaymsg so that the resulting window can be opened
# on the original workspace that the command was run on.
