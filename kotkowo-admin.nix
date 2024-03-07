{pkgs, ...}: {
  services.caddy.virtualHosts."kotkowo-admin.ravensiris.xyz".extraConfig = ''
    reverse_proxy :1337
  '';
  virtualisation.oci-containers.containers.kotkowo-admin = {
    image = "ghcr.io/kotkowo/kotkowo-admin:master";
    ports = ["1337:1337"];
    volumes = ["/var/run/postgresql:/var/run/postgresql"];
    environmentFiles = ["/run/keys/strapi.env.secret"];
  };

  systemd.timers."kotkowo-admin-update" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      Unit = "kotkowo-admin-update.service";
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  systemd.services."kotkowo-admin-update" = {
    script = ''
      set -eu
      ${pkgs.podman}/bin/podman pull ghcr.io/kotkowo/kotkowo-admin:master
      ${pkgs.systemd}/bin/systemctl restart podman-kotkowo-admin
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
