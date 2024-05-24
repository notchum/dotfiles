#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Installs my preferred fonts

if [[ $1 -eq "save" ]] ; then
    dconf dump / > $XDG_CONFIG_HOME/dconf-settings.ini
fi

if [[ $1 -eq "restore" ]] ; then
    dconf load -f / < $XDG_CONFIG_HOME/dconf-settings.ini
fi

