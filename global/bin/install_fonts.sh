#!/bin/bash

## Author ----------------------------
# @notchum

## Description ----------------------------
# Installs my preferred fonts
# 
# NOTE: only works for ZIP assets for now..

## Directories ----------------------------
FONT_DIR=$HOME/.local/share/fonts

download_font_asset_github () {
    font_name=$1
    file_name=$font_name.zip
    repo_name=$2
    api_url=https://api.github.com/repos/"$repo_name"/releases/latest

    cd "$FONT_DIR" || exit

    http_code="$(curl -w '%{http_code}\n' -z "$file_name" -LOR "$(curl -s "$api_url" | jq -r --arg file_name "$file_name" '.assets[] | select(.name == $file_name).browser_download_url')")"
    
    if [[ $http_code -eq 304 ]] ; then
        echo "$font_name up to date. Skipping..."
    else
        echo "$font_name updated. Unpacking..."
        [ -s "$file_name" ] && unzip -o "$file_name" -d "$font_name"
    fi
}

# Define the list of fonts with their repo name (e.g., "FontName GithubUser/RepoName")
fonts=(
    "JuliaMono cormullion/juliamono"
    "Hack ryanoasis/nerd-fonts"
    "Hasklig ryanoasis/nerd-fonts"
    "Iosevka ryanoasis/nerd-fonts"
    "Noto ryanoasis/nerd-fonts"
)

# Loop over each font and download it
OLDIFS=$IFS
IFS=' '
for font in "${fonts[@]}" ; do
    set -- $font # Convert the "tuple" into the param args $1 $2...
    download_font_asset_github "$1" "$2"
done
IFS=$OLDIFS
