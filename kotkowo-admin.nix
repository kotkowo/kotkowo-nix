{...}: {
  virtualisation.oci-containers.backend = "docker";
  virtualisation.oci-containers.containers = {
    kotkowo-admin = {
      image = "ghcr.io/kotkowo/kotkowo-admin:master";
      ports = ["1337:1337"];
      volumes = ["/var/run/postgresql:/var/run/postgres"];
    };
  };
}
