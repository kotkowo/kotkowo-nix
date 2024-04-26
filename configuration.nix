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
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCvbcePds/kzNbdqV2h1dyb4FaSjdWW9ohi2xPjDGikWF75xub0CgX1Fe4EvFXQKG4w2kjapvCtq+nD6AasxxADecQ5kPtnppR3xGe3qs1cY9crj3/PhFeH/KOCDrnFdxWwvq41rGjdzcGJravh4pcsFNN2/lVOqWR1UV8jKdaUXK8m/lNjJYHHEHxzEaSg1upGkip1WsOvl0ZhzzN8XjQ1+fOlwMVLDyI0u41fHabbmeG7DlD7xh9A7n2ULmUQ1ZDnROgT4cdw6z/D8skTsePtcl9CH3nR8yESbs+qqJISnTlsMBe11iSxix8ls9Hfo6UORES+hs82tV0DU2WPd1D+FF9xnf9/UkzwTrJYktKJMNCDFVhTlO3XWLUiaTZ0Ye2N0Yuaa0jWpVF2oTVCi3yGJEFd3Nd78VR+nBZqv3sQthX/YOogmS75VothV6pxlGT3kgvg3qR4C9jthN7Eywhuu32ipTMA1dxm8MFmcRez9VkWzRpC6OnNMDgPki2oxcU= q@stein"
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
