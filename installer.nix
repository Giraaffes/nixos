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

  boot.extraModulePackages = [ 
    config.boot.kernelPackages.rtl8188gu 
  ];
  
  environment.systemPackages = with pkgs; [
    usbutils
    git
  ];
}