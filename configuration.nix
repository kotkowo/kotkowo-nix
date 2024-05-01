{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # boot.loader.grub.enable = false;
  # boot.loader.generic-extlinux-compatible.enable = true;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

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
    settings.PasswordAuthentication = false;
    settings.KbdInteractiveAuthentication = false;
  };

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIC4duy6jXTVgjst3f9zHNMKxWodvXc2aN1JV0uh/9Zyi"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK9Al4LsSHmhaZ75PPycON6ifkumNoTWAWRMue+6hwMx"
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBOFhn5qz3k6kIgTkMTN4k75Fss0THO9CHZFCyc9jIgd2N/s9Oyl1YdOvG850sJf/zVqYXmZ74HzMANqsAA5XTgw="
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  environment.defaultPackages = [];

  environment.systemPackages = with pkgs; [
    neovim
  ];

  system.stateVersion = "23.11"; # Did you read the comment?
}
