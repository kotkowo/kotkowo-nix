{pkgs, ...}: {
  services.caddy.virtualHosts."kotkowo.ravensiris.xyz".extraConfig = ''
    reverse_proxy :4000
  '';
  virtualisation.oci-containers.containers.kotkowo = {
    image = "ghcr.io/kotkowo/kotkowo:latest";
    ports = ["4000:4000"];
    environmentFiles = ["/run/keys/kotkowo.env.secret"];
  };

  systemd.timers."kotkowo-update" = {
    wantedBy = ["timers.target"];
    timerConfig = {
      Unit = "kotkowo-update.service";
      OnCalendar = "daily";
      Persistent = true;
    };
  };

  systemd.services."kotkowo-update" = {
    script = ''
      set -eu
      ${pkgs.podman}/bin/podman pull ghcr.io/kotkowo/kotkowo:latest
      ${pkgs.systemd}/bin/systemctl restart podman-kotkowo
    '';
    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
  };
}
