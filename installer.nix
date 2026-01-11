{ config, pkgs, modulesPath, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  hardware.enableAllFirmware = true;
  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "da_DK.UTF-8";
  console.keyMap = "dk";
  
  networking.networkmanager.enable = true;
  hardware.usb-modeswitch.enable = true;
  services.usbmuxd.enable = true;

  boot.extraModulePackages = with config.boot.kernelPackages; [
    rtl8821cu
  ];
  
  environment.systemPackages = with pkgs; [
    usbutils
    git
  ];
}
