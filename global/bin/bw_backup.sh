#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Creates an encrypted backup of a Bitwarden
# vault in a backup directory. The backup
# will be password-protected with the master
# password to the vault.
#
# Intended to be triggered periodically by
# another script since user input is required.
#
# Automatically purges old exported vaults
# from the backup directory, so that only the
# latest copy is present. If there is a
# specific file that shouldn't be purged,
# put 'KEEP' in the filename manually.

## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m'    BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m'  BPurple='\033[1;35m' BCyan='\033[1;36m'  BWhite='\033[1;37m'

## Directories ----------------------------
BACKUP_DIR="${HOME}/.backup/bw/"

check_bw() {
  if ! bw login --check &> /dev/null ; then
    echo -e ${BRed}"[*] You need to login to Bitwarden before running this script." ${Color_Off}
    exit 1
  fi
}

lock_bw() {
  echo -e ${BYellow}"[*] Locking Bitwarden..." ${Color_Off}
  bw lock
  unset $BW_SESSION
}

unlock_bw() {
  echo -e ${BYellow}"[*] Checking Bitwarden password..." ${Color_Off}

  local output
  output="$(bw unlock $1 --raw 2>&1)"
  local exit_code=$?

  if [[ $exit_code -eq 0 ]] ; then
    export BW_SESSION="$output"
  else
    if [[ "$output" == *"Invalid master password."* ]] ; then
      echo -e ${BRed}"[*] Invalid master password." ${Color_Off}
      exit 1
    fi
  fi
}

clean_backup_dir() {
  # Find the latest backup file (excluding any with the word KEEP)
  latest_file=$(/usr/bin/ls -t "$BACKUP_DIR" | grep -v "KEEP" | head -n 1)

  # Find all files except the latest and any with the word KEEP
  files_to_delete=$(/usr/bin/ls "$BACKUP_DIR" | grep -v "KEEP" | grep -v "$latest_file")

  # Delete the old files
  for file in $files_to_delete ; do
    rm "$BACKUP_DIR/$file"
  done
}

main() {
  # Create the backup directory if it doesn't exist
  mkdir -p ${BACKUP_DIR}

  # Make sure that the Bitwarden CLI is logged in
  check_bw

  # Get vault password
  echo -ne ${BCyan}"[*] Enter Bitwarden password: " ${Color_Off}
  read -s input
  echo

  # Unlock the vault with the entered password
  # Fails if the password is incorrect
  unlock_bw "$input"

  # Create the backup
  bw export --output ${BACKUP_DIR} --format encrypted_json --password "$input"

  # Lock the vault after we're done
  lock_bw

  # Clean up the backup directory
  clean_backup_dir
  exit 0
}

main "$@"
