{
  description = "My NixOS flake";

  inputs = {
    pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "pkgs";
  };

  outputs = { pkgs, home-manager, ... }:
  let
    mkSystem = configPath: pkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit home-manager; };
      modules = [
        { nixpkgs.config.allowUnfree = true; }
        home-manager.nixosModules.default
        ./configuration.nix
        configPath
      ];
    };
  in
  {
    nixosConfigurations.marcus-mor = mkSystem ./hosts/marcus-mor/configuration.nix;
  };
}
