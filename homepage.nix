{...}: {
  services.caddy = {
    enable = true;
    virtualHosts."ravensiris.xyz".extraConfig = ''
      reverse_proxy :4848
    '';
  };

  services.ravensiris-web = {
    enable = true;
    secretKeyBaseFile = "/run/keys/homepage-secret-base-file";
    databaseUrlFile = "/run/keys/homepage-db-url";
    host = "ravensiris.xyz";
    port = 4848;
  };
}
