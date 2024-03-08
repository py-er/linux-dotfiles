#!/usr/bin/env bash

sudo echo &>/dev/null

## variable set
rebuild=false
reboot=false
user=$(whoami)

## Fetch conf files from github
git clone "https://github.com/py-er/linux-dotfiles.git"
cd linux-dotfiles/nixos-build/config-files

### Functions
copy_sudo() {
    file=$1
    path1=$2
    path2=$3
    if [ "$(diff "$path2" "$path1")" ]; then
        sudo cp $path2 $path1
        echo "$file has been updated!"
        rebuild = $4
        reboot = $5
    else
        echo "Skipping $file! Allready latest build!"
    fi
}

copy_home() {
    file=$1
    path1=$2
    path2=$3
    if [ "$(diff "$path2" "$path1")" ]; then
        cp $path2 $path1
        echo "$file has been updated!"
        rebuild = $4
        reboot = $5
    else
        echo "Skipping $file! Allready latest build!"
    fi
}

### Nix config
if [ ! -e "/etc/nixos/configuration.nix" ]; then
    echo "Cant find /etc/nixos/configuration.nix, exiting"
    exit 1
fi
    # configuration.nix
    file="configuration.nix"
    path1="/etc/nixos/$file"
    path2="etc/nixos/$file"
    copy_sudo $file $path1 $path2 true false

### Home config
## hypr folder
hyprPath="/home/$user/.config/hypr"
if [ ! -d "$hyprPath" ]; then
    echo "Creating folder: $hyprPath"
    mkdir -p "$hyprPath"
fi
    # hyprland.conf
    file="hyprland.conf"
    path1="$hyprPath/$file"
    path2="home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false false 

    # hyprpaper.conf
    file="hyprpaper.conf"
    path1="$hyprPath/$file"
    path2="home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false true

    # hypridle.conf
    file="hypridle.conf"
    path1="$hyprPath/$file"
    path2="home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false true

    # hyprlock.conf
    file="hyprlock.conf"
    path1="$hyprPath/$file"
    path2="home/.config/hypr/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false true

    # wallpapers
    file="wallpapers"
    path1="$hyprPath/$file"
    path2="home/.config/hypr/$file/*"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    cp -r $path2 $path1; echo "$file has been updated!"

## waybar folder
waybarPath="/home/$user/.config/waybar"
if [ ! -d "$waybarPath" ]; then
    echo "Creating folder: $waybarPath"
    mkdir -p "$waybarPath"
fi
    # config
    file="config"
    path1="$waybarPath/$file"
    path2="home/.config/waybar/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false true

    # style.css
    file="style.css"
    path1="$waybarPath/$file"
    path2="home/.config/waybar/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false true

## alacritty folder
alacrittyPath="/home/$user/.config/alacritty"
if [ ! -d "$alacrittyPath" ]; then
    echo "Creating folder: $alacrittyPath"
    mkdir -p "$alacrittyPath"
fi
    # alacritty.yml
    file="alacritty.yml"
    path1="$alacrittyPath/$file"
    path2="home/.config/alacritty/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    copy_home $file $path1 $path2 false false

### Finishing upp
cd - &>/dev/null
rm -rf linux-dotfiles 
echo
echo Conf update completed!
$reboot && echo Reboot recommended! Run: sudo reboot now
$rebuild && echo Rebuild recommended! Run: sudo nixos-rebuild switch