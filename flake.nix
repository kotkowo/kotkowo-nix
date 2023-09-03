{
  description = "kotkowo nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ {
    nixpkgs,
    nixpkgs-unstable,
    ...
  }: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs-unstable {
          system = "x86_64-linux";
        };
      };

      ravensiris = {
        deployment.targetHost = "49.13.30.46";
        deployment.buildOnTarget = true;
        nixpkgs.system = "aarch64-linux";

        imports = [
          ./configuration.nix
          ./postgres.nix
          ./kotkowo-admin.nix
        ];
      };
    };
  };
}
