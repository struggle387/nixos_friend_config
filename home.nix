{ config, pkgs, ... }:

{
  home.username = "usr";
  home.homeDirectory = "/home/usr";

  programs.bash = {
    enable = true;
    shellAliases = {
      update = "sudo nix flake update && sudo nixos-rebuild switch";
    };

 initExtra = ''
      export PS1='\[\e[38;5;76m\]\u\[\e[0m\]@\[\e[38;5;32m\]\w\[\e[0m\] \\$ '
    '';
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
