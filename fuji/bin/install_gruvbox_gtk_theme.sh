#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Installs the Gruvbox GTK theme and icons

## Directories ----------------------------
ICONS_DIR=$HOME/.local/share/icons
THEMES_DIR=$HOME/.themes
GTK4_CFG_DIR=$HOME/.config/gtk-4.0
TEMP_DIR=/tmp/tmp-gruvbox-theme

## Links ----------------------------
THEME_LINK=https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme
ICON_LINK=https://github.com/SylEleuth/gruvbox-plus-icon-pack

# Install the theme (and icons that come with it)
git clone $THEME_LINK $TEMP_DIR
cp -r $TEMP_DIR/themes/* "$THEMES_DIR"
cp -r $TEMP_DIR/icons/* "$ICONS_DIR"
cp --symbolic-link "$THEMES_DIR"/Gruvbox-Dark-BL/gtk-4.0/* "$GTK4_CFG_DIR"
rm -rf $TEMP_DIR

# Install the gbox+ icons
git clone $ICON_LINK $TEMP_DIR
cp -r $TEMP_DIR/Gruvbox-Plus-Dark "$ICONS_DIR"
