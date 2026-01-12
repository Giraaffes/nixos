{ config, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "marcus-mor";

  hardware.usb-modeswitch.enable = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821cu
  ];
  
  environment.systemPackages = with pkgs; [
    usbutils
  ];

  home-manager.users.marcus.home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nix-config#marcus-mor";
    rebuild-reboot = "sudo nixos-rebuild boot --flake ~/nix-config#marcus-mor && reboot";
  };
}

