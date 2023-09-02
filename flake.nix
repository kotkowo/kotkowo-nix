{
  description = "kotkowo nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    agenix.url = "github:ryantm/agenix";
  };

  outputs = inputs @ {
    nixpkgs,
    agenix,
    ...
  }: {
    nixosConfigurations.ravensiris = nixpkgs.lib.nixosSystem {
      system = "armv7l-linux";
      modules = [./configuration.nix];
    };
  };
}
