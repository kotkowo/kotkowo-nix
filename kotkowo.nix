{...}: {
  services.caddy.virtualHosts."kotkowo.ravensiris.xyz".extraConfig = ''
    reverse_proxy :4000
  '';
  virtualisation.oci-containers.containers.kotkowo = {
    image = "ghcr.io/kotkowo/kotkowo:latest";
    ports = ["4000:4000"];
    environmentFiles = ["/run/keys/kotkowo.env.secret"];
  };
}
