{ pkgs, ... }:
{
  imports = [
    ./home.nix
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader = {
    systemd-boot.enable = false;
    timeout = 3;
    grub.enable = true;
    grub.useOSProber = true;
  };

  swapDevices = [{ device = "/swapfile"; size = 8 * 1024; }];

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    okular
    kwalletmanager
    plasma-browser-integration
  ];

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "en_US.UTF-8";
  services.xserver.xkb.layout = "dk";
  console.useXkbConfig = true;

  networking.networkmanager.enable = true;
  services.usbmuxd.enable = true;

  virtualisation.docker.enable = true;

  users.users.marcus = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.bash;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  system.stateVersion = "26.05";
}

