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
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; sudo cp $path2 $path1; echo "$file has been updated!"; rebuild=true; fi

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
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; fi

    # hyprpaper.conf
    file="hyprpaper.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; reboot=true; fi

    # hypridle.conf
    file="hypridle.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; reboot=true; fi

    # hyprlock.conf
    file="hyprlock.conf"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; reboot=true; fi

    # wallpapers
    file="wallpapers"
    path1="$hyprPath/$file"
    path2="./home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp -r $path2 $path1; echo "$file has been updated!"; fi

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
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; reboot=true; fi

    # style.css
    file="style.css"
    path1="$waybarPath/$file"
    path2="./home/.config/waybar/$file"
    if [ ! -e "$path1" ]; then; touch "$path1"; fi
    if diff "$path2" "$path1" &> /dev/null; then; echo "Skipping $file! allready latest build!"; else; cp $path2 $path1; echo "$file has been updated!"; reboot=true; fi

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