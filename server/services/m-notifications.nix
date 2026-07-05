{ ... }: {
  systemd.tmpfiles.rules = [
    "d /var/lib/m-notifications-storage 0755 1000 1000 -"
  ];

  virtualisation.oci-containers.containers.m-notifications = {
    image = "localhost:5000/m-notifications:latest";
    environment = {
      STORAGE_PATH = "/home/node/app/storage";
      PROXY_URL = "http://100.91.112.112:8888";
      NODE_ENV = "production";
    };
    volumes = [
      "/var/lib/m-notifications-storage:/home/node/app/storage"
    ];
  };
}