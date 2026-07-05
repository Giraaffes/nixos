{ ... }: {
  services.dockerRegistry = {
    enable = true;
    listenAddress = "127.0.0.1";
    port = 5000;
    enableDelete = true; 
  };

  virtualisation.oci-containers.containers.watchtower = {
    image = "nickfedor/watchtower";
    volumes = [
      "/var/run/docker.sock:/var/run/docker.sock"
    ];
    cmd = [
      "--interval" "60"
      "--cleanup"
      "--include-restarting"
    ];
  };
}