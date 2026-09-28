{ config, pkgs, ... }:
{
  services.pihole-ftl = {
    enable = true;
    settings = {
      dns.upstreams = [
        "9.9.9.9"
        "1.1.1.1"
      ];
      dns.hosts = [
        "192.168.50.1   router.net"
        # "192.168.10.2   router2.net"
        "192.168.10.1   router3.net"
        "192.168.10.103 server.net"
        "192.168.10.20 dragan-desktop.net"
        "192.168.10.205 dragan-laptop.net"
      ];
    };
    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }
    ];
  };

  services.pihole-web = {
    enable = true;
    ports = [ "8081" ];
  };

  networking.firewall.allowedTCPPorts = [
    8081 # pihole-web
  ];
}
