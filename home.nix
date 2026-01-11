{ pkgs, home-manager, ... }:
{
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
}