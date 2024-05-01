{pkgs, ...}: let
  env = {
    GLITCHTIP_DOMAIN = "https://glitchtip.ravensiris.xyz";
    DEFAULT_FROM_EMAIL = "info@ravensiris.xyz";
    ENABLE_USER_REGISTRATION = "FALSE";
    DATABASE_URL = "postgresql:///postgres?host=/var/run/postgresql&user=postgres";
    REDIS_URL = "redis://127.0.0.1:6379/1";
    CELERY_WORKER_AUTOSCALE = "1,3";
    CELERY_WORKER_MAX_TASKS_PER_CHILD = "10000";
    PORT = "8000";
  };
in {
  services.caddy.virtualHosts."glitchtip.ravensiris.xyz".extraConfig = ''
    reverse_proxy :8000
  '';

  virtualisation.oci-containers.containers = {
    glitchtip = {
      image = "glitchtip/glitchtip:v4.0.8";
      autoStart = true;
      environmentFiles = ["/run/keys/glitchtip.env.secret"];
      volumes = [
        "/var/run/postgresql:/var/run/postgresql"
      ];
      extraOptions = [
        "--network=host"
      ];
      environment = env;
    };

    glitchtip-worker = {
      image = "glitchtip/glitchtip:v4.0.8";
      autoStart = true;
      entrypoint = "./bin/run-celery-with-beat.sh";
      environmentFiles = [];
      volumes = [
        "/var/run/postgresql:/var/run/postgresql"
      ];
      extraOptions = [
        "--network=host"
      ];
      environment = env;
    };
  };
}
