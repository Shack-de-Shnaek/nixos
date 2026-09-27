{ pkgs, ... }:
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
}
