{
  description = "kotkowo nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    homepage = {
      url = "github:ravensiris/ravensiris.xyz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    homepage,
    ...
  }: {
    colmena = {
      meta = {
        nixpkgs = import nixpkgs {
          system = "x86_64-linux";
        };
      };

      ravensiris = {
        nixpkgs.system = "aarch64-linux";
        deployment.targetHost = "49.13.30.46";
        deployment.buildOnTarget = true;
        deployment.keys."strapi.env.secret" = {
          keyCommand = ["pass" "kotkowo/strapi.env"];
        };
        deployment.keys."kotkowo.env.secret" = {
          keyCommand = ["pass" "kotkowo/kotkowo.env"];
        };
        deployment.keys."glitchtip.env.secret" = {
          keyCommand = ["pass" "kotkowo/glitchtip.env"];
        };

        deployment.keys."homepage-secret-base-file" = {
          keyCommand = ["pass" "homepage/secret-key-base"];
        };

        # local connections do not require password
        deployment.keys."homepage-db-url" = {
          keyCommand = ["echo" "ecto://postgres@localhost/postgres"];
        };

        virtualisation.oci-containers.backend = "podman";
        networking.firewall.allowedTCPPorts = [80 443];

        imports = [
          homepage.outputs.packages.aarch64-linux.nixosModule
          ./configuration.nix
          ./postgres.nix
          ./kotkowo-admin.nix
          ./kotkowo.nix
          ./glitchtip.nix
          ./redis.nix
          ./homepage.nix
        ];
      };
    };
  };
}
