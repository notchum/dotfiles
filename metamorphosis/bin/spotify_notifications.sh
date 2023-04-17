#!/bin/bash

if [ "$PLAYER_EVENT" = "start" ] || [ "$PLAYER_EVENT" = "change" ];
then
	trackName=$(playerctl -p spotifyd,%any metadata title)
	artistName=$(playerctl -p spotifyd,%any metadata --format "{{ artist }}")
	# artistAndAlbumName=$(playerctl -p spotifyd,%any metadata --format "{{ artist }} ({{ album }})")

	notify-send -u low "$trackName" "$artistName" --icon=$HOME/bin/spotify.png
fi
