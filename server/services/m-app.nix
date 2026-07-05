{ pkgs, ... }: {
  systemd.services."docker-m-app-network" = {
    after = [ "docker.service" ];
    requires = [ "docker.service" ];
    wantedBy = [ "docker-m-app.service" "docker-m-app-db.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      ${pkgs.docker}/bin/docker network inspect m-app-network >/dev/null 2>&1 || \
      ${pkgs.docker}/bin/docker network create m-app-network
    '';
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/m-app-pgdata 0755 1000 1000 -"
  ];

  virtualisation.oci-containers.containers.m-app = {
    image = "localhost:5000/m-app:latest";
    ports = [ "8080:8080" ];
    dependsOn = [ "m-app-db" ];
    extraOptions = [ "--network=m-app-network" ];
    environment = {
      DATABASE_URL = "postgres://app:app@m-app-db:5432/m-app";
    };
  };

  virtualisation.oci-containers.containers.m-app-db = {
    image = "postgres:15-alpine";
    ports = [ "5432:5432" ];
    extraOptions = [ "--network=m-app-network" ];
    environment = {
      POSTGRES_USER = "app";
      POSTGRES_PASSWORD = "app";
      POSTGRES_DB = "m-app";
    };
    volumes = [
      "/var/lib/m-app-pgdata:/var/lib/postgresql/data"
    ];
  };

  networking.firewall.allowedTCPPorts = [ 80 443 ];

  security.acme.certs."m-app-cert" = {
    domain = "marcus.cool";
    extraDomainNames = [ "www.marcus.cool" "pwa.marcus.cool" ];
    webroot = "/var/lib/acme/acme-challenge";
    group = "nginx";
  };

  services.nginx.virtualHosts."marcus.cool" = {
    serverAliases = [ "www.marcus.cool" "pwa.marcus.cool" ];
    forceSSL = true;
    useACMEHost = "m-app-cert";

    locations."/".proxyPass = "http://127.0.0.1:8080";
  };
}