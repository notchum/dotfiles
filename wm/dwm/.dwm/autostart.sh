#!/bin/sh

# Exec
#picom -c -o "0.90" -r 20 &
/home/pranav/.fehbg &
dwmblocks &
sleep 2
/home/pranav/bin/settp &
dunst &
#xautolock -time 10 -locker slock &

# Kill duplicate processes created in the previous dwm restart

# autostart.sh
NEWEST_PID=$(pgrep -n 'autostart.sh')
test $NEWEST_PID && pgrep 'autostart.sh' | grep -vw $NEWEST_PID | xargs -r kill

# dwmblocks
NEWEST_PID=$(pgrep -n 'dwmblocks')
test $NEWEST_PID && pgrep 'dwmblocks' | grep -vw $NEWEST_PID | xargs -r kill