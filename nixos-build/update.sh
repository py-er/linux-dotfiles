#!/usr/bin/env bash

sudo echo &>/dev/null

## variable set
rebuild=false
reboot=false

## Fetch conf files from github
git clone "https://github.com/py-er/linux-dotfiles.git"
cd linux-dotfiles/nixos-build

### Nix config
if [ ! -e "/etc/nixos/configuration.nix" ]; then
    echo "Cant find /etc/nixos/configuration.nix, exiting"
    exit 1
fi
    # configuration.nix
    file="configuration.nix"
    path1="/etc/nixos/$file"
    path2="./etc/nixos/$file"
    [ "$(diff "$path2" "$path1")" ] && (sudo cp $path2 $path1; echo "$file has been updated!"; rebuild=true) || (echo "Skipping $file! Allready latest build!")

### Home config
## hypr folder
hyprPath="~/.config/hypr"
if [ ! -d "$hyprPath" ]; then
    echo "Creating folder: $hyprPath"
    mkdir -p "$hyprPath"
fi
    # hyprland.conf
    file="hyprland.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!") || (echo "Skipping $file! Allready latest build!")

    # hyprpaper.conf
    file="hyprpaper.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!"; reboot=true) || (echo "Skipping $file! Allready latest build!")

    # hypridle.conf
    file="hypridle.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!"; reboot=true) || (echo "Skipping $file! Allready latest build!")

    # hyprlock.conf
    file="hyprlock.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!"; reboot=true) || (echo "Skipping $file! Allready latest build!")

    # wallpapers
    file="wallpapers"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp -r $path2 $path1; echo "$file has been updated!") || (echo "Skipping $file! Allready latest build!")

## waybar folder
waybarPath="~/.config/waybar"
if [ ! -d "$waybarPath" ]; then
    echo "Creating folder: $waybarPath"
    mkdir -p "$waybarPath"
fi
    # config
    file="config"
    path1="$waybarPath/$file"
    path2="./home/.config/waybar/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!"; reboot=true) || (echo "Skipping $file! Allready latest build!")

    # style.css
    file="style.css"
    path1="$waybarPath/$file"
    path2="./home/.config/waybar/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!"; reboot=true) || (echo "Skipping $file! Allready latest build!")

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
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!") || (echo "Skipping $file! Allready latest build!")

### Finishing upp
cd -
rm -rf linux-dotfiles 
echo
echo Conf update completed!
$reboot && echo Reboot recommended! Run: sudo reboot now
$rebuild && echo Rebuild recommended! Run: sudo nixos-rebuild switch