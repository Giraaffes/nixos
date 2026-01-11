{ config, pkgs, home-manager, ... }:
{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "marcus-mor";

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821cu
  ];
  
  environment.systemPackages = with pkgs; [
    usbutils
  ];
  
  hardware.usb-modeswitch.enable = true;
}

