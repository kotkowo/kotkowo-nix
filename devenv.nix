{pkgs, ...}: {
  packages = [
    pkgs.colmena
    pkgs.nixpacks
    pkgs.sops
  ];
}
