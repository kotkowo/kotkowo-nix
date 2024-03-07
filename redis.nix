{...}: {
  services.redis = {
    servers = {
      "" = {
        enable = true;
        bind = null;
      };
    };
  };
}
