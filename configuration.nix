{ pkgs, ... }:
{
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = false;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    oxygen
    elisa
    gwenview
    okular
    kwalletmanager
  ];

  time.timeZone = "Europe/Copenhagen";
  i18n.defaultLocale = "da_DK.UTF-8";
  services.xserver.xkb.layout = "dk";
  console.useXkbConfig = true;

  networking.networkmanager.enable = true;

  environment.systemPackages = with pkgs; [
    usbmuxd
  ];

  services.usbmuxd.enable = true;
  systemd.services.usbmuxd.wantedBy = [ "multi-user.target" ];

  users.users.marcus = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.bash;
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };
  home-manager.users.marcus = {
    programs.bash.enable = true;

    home.packages = with pkgs; [
      firefox
      vscode dbeaver-bin
      git gh
    ];
    home.shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake ~/nix-config";
      rebuild-reboot = "sudo nixos-rebuild boot --flake ~/nix-config && reboot";
    };

    home.stateVersion = "25.11";
  };

  system.stateVersion = "26.05";
}

