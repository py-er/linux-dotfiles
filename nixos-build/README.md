# nixos-build

 - Update nixos buidl:
 ```bash
wget -qO- https://raw.githubusercontent.com/py-er/linux-dotfiles/main/nixos-build/update.sh | bash
 ```


 - Run test script:
 ```bash
wget -qO- https://raw.githubusercontent.com/py-er/linux-dotfiles/main/nixos-build/test.sh | bash
 ```


install unstable branch:
```bash
nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable && sudo nix-channel --update
 ```
