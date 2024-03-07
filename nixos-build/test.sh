#!/usr/bin/env bash

sudo echo &>/dev/null

echo $user

## variable set
rebuild=false
reboot=false
user=$(whoami)

## Fetch conf files from github
git clone "https://github.com/py-er/linux-dotfiles.git"
cd linux-dotfiles/nixos-build
pwd
## alacritty folder
alacrittyPath="/home/$user/.config/alacritty"
if [ ! -d "$alacrittyPath" ]; then
    echo "Creating folder: $alacrittyPath"
    mkdir -p "$alacrittyPath"
fi
    # alacritty.yml
    file="alacritty.yml"
    path1="$alacrittyPath/$file"
    path2="./home/.config/alacritty/$file"
    if [ ! -e "$path1" ]; then touch "$path1"; fi
    [ "$(diff "$path2" "$path1")" ] && (cp $path2 $path1; echo "$file has been updated!") || (echo "Skipping $file! allready latest build!")

### Finishing upp
cd -
rm -rf linux-dotfiles 
echo
echo Conf update completed!
$reboot && echo Reboot recommended! Run: sudo reboot now
$rebuild && echo Rebuild recommended! Run: sudo nixos-rebuild switch