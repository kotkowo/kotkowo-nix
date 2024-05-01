{pkgs, ...}: {
  services.caddy.virtualHosts."grafana.ravensiris.xyz".extraConfig = ''
    reverse_proxy :4200
  '';

  services.grafana = {
    enable = true;
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 4200;
        domain = "grafana.ravensiris.xyz";
      };
    };
  };
}
