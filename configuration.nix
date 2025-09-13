{ config, pkgs, lib, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes " ];
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "nixos";

  networking.networkmanager.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = false;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

  };
  
  users.users.usr = {
    isNormalUser = true;
    description = "usr";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };

   environment.gnome.excludePackages = with pkgs; [
   baobab
   cheese
   eog
   epiphany
   simple-scan
   totem
   yelp
   geary
   seahorse    
   gnome-calculator 
   gnome-calendar 
   gnome-characters 
   gnome-clocks 
   gnome-contacts
   gnome-font-viewer 
   gnome-maps 
   gnome-music 
   gnome-photos 
   gnome-weather 
   pkgs.gnome-connections
   gnome-tour
   snapshot
   decibels
   gnome-text-editor
   loupe
   gnome-console
  ];

  services.xserver.excludePackages = [ pkgs.xterm ];
  
  environment.systemPackages = with pkgs; [
  #GNOME Apps
  gnome-terminal
  gnome-tweaks
  gedit
  gthumb

  # Text Editors
  vim
  micro-with-xclip

  # Browsers
  firefox
  tor-browser
  
  # System packages
  wget
  git
  unzip
  tree

  # Media players
  vlc
  rhythmbox

  # Password and PGP
  bitwarden-desktop

  # Themes
  xcursor-pro
  papirus-icon-theme
  
  # Lutris and WINE 
  lutris
  umu-launcher
  wineWowPackages.staging
  winetricks
  protonup-qt
  
  # GNOME Extensions
  gnomeExtensions.impatience
  gnomeExtensions.blur-my-shell
  
  #Extra 
  thunderbird
  obsidian
  steam-run
  discord
  maltego
  ];

  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

   programs.gnupg.agent = {
     enable = true;
  #   enableSSHSupport = true;

   };

  system.stateVersion = "25.05"; # Did you read the comment? no lol

}
