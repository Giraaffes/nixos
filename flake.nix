{
  description = "My NixOS flake";

  inputs = {
    pkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };
    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "pkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "pkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = { pkgs, home-manager, plasma-manager, nur, ... }:
  let
    mkSystem = hostConfig: pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        home-manager.nixosModules.home-manager
        {
          nixpkgs.config.allowUnfree = true;
          home-manager.sharedModules = [ plasma-manager.homeModules.plasma-manager ];
        }
        nur.modules.nixos.default
        ./configuration.nix
        hostConfig
      ];
    };
  in
  {
    nixosConfigurations.marcus-mor = mkSystem ./hosts/marcus-mor/configuration.nix;
    nixosConfigurations.acto = mkSystem ./hosts/acto/configuration.nix;
  };
}
