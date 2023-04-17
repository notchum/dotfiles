#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Setup a terminal based Spotify instance
# with spotify-tui and spotifyd!
#
# Requires a Bitwarden vault and bitwarden-cli
# to access it. Then, create three secure notes
# and fill them in with your info:
#   SPOTIFY_USER_ID
#   SPOTIFY_CLIENT_ID
#   SPOTIFY_CLIENT_SECRET

## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m'    BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m'  BPurple='\033[1;35m' BCyan='\033[1;36m'  BWhite='\033[1;37m'

## Directories ----------------------------
SPOTIFY_TUI_DIR=$HOME/.config/spotify-tui
# SPOTIFYD_DIR=$HOME/.config/spotifyd
SPOTIFYD_CONFIG=$HOME/.config/spotifyd/spotifyd.conf

unlock_bw() {
  if [[ -z $BW_SESSION ]] ; then
    echo -e ${BYellow}"[*] Bitwarden locked - unlocking into a new session..." ${Color_Off}
    local bw_session
    bw_session="$(bw unlock --raw)"
    export BW_SESSION="$bw_session"
  else
    echo -e ${BYellow}"[*] Bitwarden unlocked - proceeding..." ${Color_Off}
  fi
}

lock_bw() {
  echo -e ${BYellow}"[*] Locking Bitwarden..." ${Color_Off}
  bw lock
  unset $BW_SESSION
}

load_github() {
  local -r github_pat_id="e3e46z6b-a643-4j13-9820-ae4313fg75nd"
  local github_token
  github_token="$(bw get notes $github_pat_id)"
  export GITHUB_OAUTH_TOKEN="$github_token"
  export GITHUB_TOKEN="$github_token"
  export GIT_TOKEN="$github_token"
}

spotifyd_setup() {
  # cp -rf $(pwd)/.config/spotifyd/spotifyd.conf "$SPOTIFYD_DIR"
  local spotify_user_id
  if [[ "$1" -eq 1 ]] ; then
    echo -e ${BPurple}"[*] Grabbing SPOTIFY_USER_ID..." ${Color_Off}
    spotify_user_id="$(bw get notes SPOTIFY_USER_ID)"
  else
    read -rp "Enter Spotify username or user ID: " spotify_user_id
  fi
  echo -e ${BGreen}"[*] Filling out spotifyd configuration..." ${Color_Off}
  sed -i "/username/c\username = \"$spotify_user_id\"" "$SPOTIFYD_CONFIG"
  sed -i "/device_name/c\device_name = \"$(uname -n)\"" "$SPOTIFYD_CONFIG"
  sed -i "/onevent/c\onevent = \"bash $(pwd)/bin/spotify_notifications.sh\"" "$SPOTIFYD_CONFIG"
  sed -i "/cache_path/c\cache_path = \"$(pwd)/.cache/spotifyd\"" "$SPOTIFYD_CONFIG"
}

spotify_tui_setup() {
	if [[ ! -d "$SPOTIFY_TUI_DIR" ]] ; then
    echo -e ${BBlue}"[*] Creating spotify-tui config directory..." ${Color_Off}
		mkdir -p "$SPOTIFY_TUI_DIR"
	fi
  if [[ "$1" -eq 1 ]] ; then
    local spotify_client_id
    local spotify_client_secret
    echo -e ${BPurple}"[*] Grabbing SPOTIFY_CLIENT_ID..." ${Color_Off}
    spotify_client_id="$(bw get notes SPOTIFY_CLIENT_ID)"
    echo -e ${BPurple}"[*] Grabbing SPOTIFY_CLIENT_SECRET..." ${Color_Off}
    spotify_client_secret="$(bw get notes SPOTIFY_CLIENT_SECRET)"
    local -r redirect_uri_port=8888
    lock_bw
    echo -e ${BBlue}"[*] Configuring spotify-tui..." ${Color_Off}
    { echo "$spotify_client_id" ; echo "$spotify_client_secret" ; echo "$redirect_uri_port" ; } | spt
  else
    spt
  fi
}

usage() {
  local program_name
  program_name=${0##*/}
  cat <<EOF
Usage: $program_name [OPTIONS]
Options:
  --help      Print this message
  --bw        Use bitwarden-cli to autofill everything 
EOF
}

main() {
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    '')
      spotifyd_setup 0
      spotify_tui_setup 0
      ;;
    --bw)
      unlock_bw
      spotifyd_setup 1
      spotify_tui_setup 1
      ;;
    *)
      echo "Command not found" >&2
      exit 1
  esac
}

main "$@"
