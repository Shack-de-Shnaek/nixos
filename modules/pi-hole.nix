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
        "192.168.10.2   router2.net"
        "192.168.10.1   router3.net"
        "192.168.10.136 pi.net"
        "192.168.10.20 dragan-desktop.net"
        "192.168.10.205 dragan-laptop.net"
      ];
      misc.dnsmasq_lines = [
        "address=/server.net/192.168.10.103"
      ];
    };
    lists = [
      {
        url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
        type = "block";
        enabled = true;
        description = "hagezi blocklist";
      }

      {
        url = "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt";
        type = "block";
        enabled = true;
        description = "KADhosts blocklist";
      }
      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts";
        type = "block";
        enabled = true;
        description = "FadeMind blocklist";
      }
      {
        url = "https://v.firebog.net/hosts/static/w3kbl.txt";
        type = "block";
        enabled = true;
        description = "firebog blocklist";
      }

      {
        url = "https://adaway.org/hosts.txt";
        type = "block";
        enabled = true;
        description = "adaway blocklist";
      }
      {
        url = "https://v.firebog.net/hosts/AdguardDNS.txt";
        type = "block";
        enabled = true;
        description = "adguard blocklist";
      }
      {
        url = "https://v.firebog.net/hosts/Admiral.txt";
        type = "block";
        enabled = true;
        description = "firebog admiral blocklist";
      }

      {
        url = "https://v.firebog.net/hosts/Easyprivacy.txt";
        type = "block";
        enabled = true;
        description = "Easyprivacy blocklist";
      }
      {
        url = "https://v.firebog.net/hosts/Prigent-Ads.txt";
        type = "block";
        enabled = true;
        description = "prigent ads blocklist";
      }
      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts";
        type = "block";
        enabled = true;
        description = "fademind extra blocklist";
      }

      {
        url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt";
        type = "block";
        enabled = true;
        description = "DandelionSprout blocklist";
      }
      {
        url = "https://v.firebog.net/hosts/Prigent-Crypto.txt";
        type = "block";
        enabled = true;
        description = "prigent crypto blocklist";
      }
      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts";
        type = "block";
        enabled = true;
        description = "fademind extra extra blocklist";
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

  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
      FallbackDNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
      Domains = [ "~." ];
    };
  };
}
