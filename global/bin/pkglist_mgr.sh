#!/usr/bin/env bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Updates pacman's installed packages list.
# Cronjob is
#    @daily $HOME/bin/pkglist_mgr.sh

## Directories ----------------------------
PKGLIST_DIR=$HOME/.pkglist

if [[ ! -d "$PKGLIST_DIR" ]] ; then
  mkdir -p "$PKGLIST_DIR"
fi

# Create a list of installed packages:
pacman -Qqe > "$PKGLIST_DIR"/pkglist.txt

# Create a list of optional dependencies:
comm -13 <(pacman -Qqdt | sort) <(pacman -Qqdtt | sort) > "$PKGLIST_DIR"/optdeplist.txt

# Create a list of AUR and other foreign packages that have been installed:
pacman -Qqem > "$PKGLIST_DIR"/foreignpkglist.txt

# Install without foreign packages:
# pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort "$PKGLIST_DIR"/pkglist.txt))

# Install only foreign packages:
# paru -S $(comm -13 <(pacman -Slq | sort) <(sort $HOME/.pkglist/pkglist.txt))
