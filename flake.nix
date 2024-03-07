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

        virtualisation.oci-containers.backend = "podman";
        networking.firewall.allowedTCPPorts = [80 443];
        services.caddy = {
          enable = true;
          virtualHosts."ravensiris.xyz".extraConfig = ''
            respond "Hello, world!"
          '';
        };

        imports = [
          ./configuration.nix
          ./postgres.nix
          ./kotkowo-admin.nix
          ./kotkowo.nix
          ./glitchtip.nix
          ./redis.nix
        ];
      };
    };
  };
}
