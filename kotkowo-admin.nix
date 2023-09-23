{...}: {
  services.caddy.virtualHosts."kotkowo-admin.ravensiris.xyz".extraConfig = ''
    reverse_proxy :1337
  '';
  virtualisation.oci-containers.containers.kotkowo-admin = {
    image = "ghcr.io/kotkowo/kotkowo-admin:master";
    ports = ["1337:1337"];
    volumes = ["/var/run/postgresql:/var/run/postgresql"];
    environmentFiles = ["/run/keys/strapi.env.secret"];
  };
}
