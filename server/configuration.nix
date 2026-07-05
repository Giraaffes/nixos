{ pkgs, ... }: {
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Europe/Copenhagen";

  networking.networkmanager.enable = true;
  
  virtualisation.docker.enable = true;
  virtualisation.oci-containers.backend = "docker";

  services.tailscale.enable = true;

  services.nginx = {
    enable = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
  };
  security.acme = {
    acceptTerms = true;
    defaults.email = "marcusfaerk@gmail.com";
  };
  
  imports = [
    ./services/watchtower.nix
    ./services/m-notifications.nix
    ./services/m-app.nix
  ];

  system.stateVersion = "26.05";
}
