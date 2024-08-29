#!/bin/bash

echo "Sending backup notification..."

action=$(notify-send "Time to backup Bitwarden" \
  "Click here to backup" \
  --icon=dialog-information \
  --urgency=normal \
  --expire-time=10000 \
  --hint=int:transient:1 \
  --action="Backup Now")

if [[ $action -eq 0 ]]; then
  kitty -e bw_backup.sh
fi

