{ pkgs, ... }:
{
  nixpkgs.config.permittedInsecurePackages = [
    "ventoy-qt5-1.1.10"
  ];

  home-manager.users.marcus = {
    imports = [ ./plasma.nix ];

    programs.bash.enable = true;
    programs.git.enable = true;
    programs.git.settings.user = {
      name = "Marcus Færk Henriksen";
      email = "marcusfaerk@gmail.com";
    };
    programs.gh.enable = true;

    home.packages = with pkgs; [
      firefox
      vscode dbeaver-bin
      ventoy-full-qt
    ];

    home.stateVersion = "25.11";
  };
}
