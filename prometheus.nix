{...}: {
  services.prometheus = {
    enable = true;
    port = 9001;

    exporters = {
      node = {
        enable = true;
        enabledCollectors = ["systemd" "processes"];
        port = 9002;
      };

      postgres = {
        enable = true;
        port = 9003;
      };
    };

    scrapeConfigs = [
      {
        job_name = "node";
        static_configs = [
          {
            targets = ["127.0.0.1:9002"];
          }
        ];
      }
      {
        job_name = "postgres";
        static_configs = [
          {
            targets = ["127.0.0.1:9003"];
          }
        ];
      }
      {
        job_name = "podman";
        static_configs = [
          {
            targets = ["127.0.0.1:9882"];
          }
        ];
      }
      {
        job_name = "kotkowo";
        static_configs = [
          {
            targets = ["127.0.0.1:4000"];
          }
        ];
      }
    ];
  };

  # NOTE: runs on :9882
  virtualisation.oci-containers.containers.prometheus-podman-exporter = {
    image = "quay.io/navidys/prometheus-podman-exporter";
    autoStart = true;
    environment = {
      CONTAINER_HOST = "unix:///run/podman/podman.sock";
    };
    extraOptions = [
      "--network=host"
      # "--security-opt label=disable"
    ];
    user = "root";
    volumes = [
      "/run/podman/podman.sock:/run/podman/podman.sock"
    ];
  };
}
