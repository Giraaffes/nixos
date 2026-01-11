nix-build '<nixpkgs/nixos>' -A config.system.build.isoImage -I nixos-config=installer.nix -o installer-result
