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

  services.udev.extraRules = ''
    ACTION=="add", ATTR{idVendor}=="0bda", ATTR{idProduct}=="1a2b", RUN+="${pkgs.usb-modeswitch}/bin/usb_modeswitch -v 0bda -p 1a2b -K"
  '';
  
  environment.systemPackages = with pkgs; [
    usbutils
    usb-modeswitch
  ];

  home-manager.users.marcus.home.shellAliases = {
    rebuild = "sudo nixos-rebuild switch --flake ~/nixos#marcus-mor";
    rebuild-logout = "sudo nixos-rebuild switch --flake ~/nixos#marcus-mor && qdbus org.kde.Shutdown /Shutdown logout";
    rebuild-reboot = "sudo nixos-rebuild boot --flake ~/nixos#marcus-mor && reboot";
  };
}

