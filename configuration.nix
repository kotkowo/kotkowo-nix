{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.grub.enable = false;
  boot.loader.generic-extlinux-compatible.enable = true;

  networking.hostName = "ravensiris"; # Define your hostname.
  systemd.network.enable = true;
  systemd.network.networks."10-wan" = {
    matchConfig.Name = "enp1s0";
    networkConfig.DHCP = "ipv4";
  };

  time.timeZone = "Etc/UTC";
  i18n.defaultLocale = "en_US.UTF-8";

  services.openssh = {
    enable = true;
  };

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.defaultPackages = [];

  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "23.05"; # Did you read the comment?
}
