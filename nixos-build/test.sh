#!/usr/bin/env bash

sudo echo &>/dev/null

## variable set
rebuild=false
reboot=false

## alacritty folder
alacrittyPath="~/.config/alacritty"
if [ ! -d "$alacrittyPath" ]; then
    echo "Creating folder: $alacrittyPath"
    mkdir -p "$alacrittyPath"
fi
    # alacritty.yml
    file="alacritty.yml"
    path1="$alacrittyPath/$file"
    path2="./home/.config/alacritty/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; fi

### Finishing upp
cd -
rm -r linux-dotfiles 
echo
echo Conf update completed!
$reboot && echo Reboot recommended! Run: sudo reboot now
$rebuild && echo Rebuild recommended! Run: sudo nixos-rebuild switch