#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Send a desktop notification to backup bitwarden
# Cronjob is
#    0 13 */2 * * $HOME/bin/bw_backup_notify.sh

echo "Sending backup notification..."

action=$(notify-send "Time to backup Bitwarden" \
  "Click here to backup" \
  --icon=dialog-information \
  --urgency=normal \
  --expire-time=10000 \
  --hint=int:transient:1 \
  --action="Backup Now")

if [[ $action -eq 0 ]]; then
  kitty -e "$HOME"/bin/bw_backup.sh
fi
