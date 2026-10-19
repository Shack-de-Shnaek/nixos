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
        url = "https://adaway.org/hosts.txt";
        type = "block";
        enabled = true;
        description = "";
      }
      {
        url = "https://raw.githubusercontent.com/PolishFiltersTeam/KADhosts/master/KADhosts.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Spam/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/AdguardDNS.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Admiral.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Easylist.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Easyprivacy.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Prigent-Ads.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Prigent-Crypto.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://phishing.army/download/phishing_army_blocklist_extended.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://gitlab.com/quidsup/notrack-blocklists/raw/master/notrack-malware.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/Spam404/lists/master/main-blacklist.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/AssoEchap/stalkerware-indicators/master/generated/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://urlhaus.abuse.ch/downloads/hostfile/";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://lists.cyberhost.uk/malware.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      # maybe turn off some

      {
        url = "https://raw.githubusercontent.com/matomo-org/referrer-spam-blacklist/master/spammers.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://someonewhocares.org/hosts/zero/hosts";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/RooneyMcNibNug/pihole-stuff/master/SNAFU.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://malware-filter.gitlab.io/malware-filter/phishing-filter-hosts.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/Prigent-Malware.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://raw.githubusercontent.com/jarelllama/Scam-Blocklist/main/lists/wildcard_domains/scams.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/RPiList-Malware.txt";
        type = "block";
        enabled = true;
        description = "";
      }

      {
        url = "https://v.firebog.net/hosts/RPiList-Phishing.txt";
        type = "block";
        enabled = true;
        description = "";
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
