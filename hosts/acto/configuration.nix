{ config, pkgs, home-manager, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;

  networking.hostName = "acto";

  home-manager.users.marcus.home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#acto";
    rebuild-reboot = "sudo nixos-rebuild boot --flake ~/nixos#acto && reboot";
  };
}

