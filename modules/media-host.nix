{ config, pkgs, inputs, ... }:
let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.system;
    config = config.nixpkgs.config;
  };
in
{
  # users.users.qbittorrent = {
  #   group = "qbittorrent";
  #   isSystemUser = true;
  # };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "qbittorrent";
    torrentingPort = 6881;
  };

  services.immich = {
    enable = true;
    port = 2283;
    host = "0.0.0.0";
    openFirewall = true;
    mediaLocation = "/mnt/hdd/immich";
    accelerationDevices = null;
    package = unstable.immich;
  };

  services.prowlarr = {
    enable = true;
    openFirewall = true;
  };

  users.users.immich.extraGroups = [ "video" "render" ];
}
