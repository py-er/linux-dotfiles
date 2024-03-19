#   _   _ _      _____ _____   _____              __ _       
#  | \ | (_)    |  _  /  ___| /  __ \            / _(_)      
#  |  \| |___  _| | | \ `--.  | /  \/ ___  _ __ | |_ _  __ _ 
#  | . ` | \ \/ / | | |`--. \ | |    / _ \| '_ \|  _| |/ _` |
#  | |\  | |>  <\ \_/ /\__/ / | \__/\ (_) | | | | | | | (_| |
#  \_| \_/_/_/\_\\___/\____/   \____/\___/|_| |_|_| |_|\__, |
#                                                       __/ |
#                                                      |___/ 

{ config, pkgs, ... }:
let
  unstable = import <nixos-unstable> {};
in
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.initrd.luks.devices."luks-3ad08cbf-e02b-4152-9977-8d7d14d91b6b".device = "/dev/disk/by-uuid/3ad08cbf-e02b-4152-9977-8d7d14d91b6b";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
	enable = true;
	alsa.enable = true;
	alsa.support32Bit = true;
	pulse.enable = true;
  };

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_TIME = "sv_SE.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "se";
    xkbVariant = "";
    enable = true;
    displayManager.sddm = {
      enable = true;
      autoNumlock = true;
    };
  };

  # Enable Gnome-keyring for storing secrets (github)
  services.gnome.gnome-keyring.enable = true;

  # Enable Hyprland
  programs.hyprland = {
	enable = true;
        xwayland.enable = true;
  };

  # Set aliases
  programs.bash.shellAliases = {
    display = "loupe";
    fetchConfs = "wget -qO- https://raw.githubusercontent.com/py-er/linux-dotfiles/main/nixos-build/update.sh | bash";
  };

  # Throttle CPU
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
       governor = "powersave";
       turbo = "never";
      };
    charger = {
       governor = "performance";
       turbo = "auto";
    };
  };


  # Configure console keymap
  console.keyMap = "sv-latin1";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.pyer = {
    isNormalUser = true;
    description = "pyer";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    ## System apps
    pulseaudio
    brightnessctl
    auto-cpufreq
    gnome.gnome-keyring
    
    ## Desktop environment
    unstable.hyprland
    hyprpaper
    unstable.hypridle
    unstable.hyprlock
    unstable.hyprcursor
    xwayland
    xdg-desktop-portal-hyprland
    waybar
    rofi-wayland

    ## Terminal tools
    vim
    wget
    curl
    netcat
    unzip
    openvpn
    samba

    ## GUI tools
    webcord
    firefox
    mullvad-browser
    cura
    loupe

    ## Dev tools
    vim
    nano
    alacritty
    vscode
    git
    github-desktop
    docker
    docker-compose

    ## Hacking tools
    nmap
    burpsuite
    ffuf
    metasploit
    sqlmap
    wireshark
    tcpdump
    john
    hashcat
    enum4linux-ng
    aircrack-ng
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}