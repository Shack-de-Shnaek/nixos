{ pkgs, ... }:
{
  users.users.qbittorrent = {
    group = "qbittorrent";
    isSystemUser = true;
  };

  services.qbittorrent = {
    enable = true;
    openFirewall = true;
    user = "qbittorrent";
    group = "qbittorrent";
    port = "8079";
    torrentingPort = 6881;
  };
}
