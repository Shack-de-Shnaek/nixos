# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../modules/common.nix
      ../../modules/media-host.nix
      ../../modules/pi-hole.nix
      # ../../modules/nvidia.nix
      inputs.home-manager.nixosModules.default
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  # Use provided UUIDs instead of blkid probing (required for btrfs subvolumes)
  boot.kernelParams = [ "acpi_enforce_resources=lax" ];
  boot.kernelModules = [ "coretemp" "f71882fg" "it87" "nct6687" ];
  boot.loader.grub.fsIdentifier = "provided";

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "dragan-server"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    neovim
    curl
    killall
    hdparm
    coolercontrol.coolercontrold
    lm_sensors
    bind
  ];

  programs.coolercontrol = {
    enable = true;
  };

  # List services that you want to enable:

  services.openssh.enable = true;
  services.nfs.server = {
    enable = true;
    exports = ''
      /mnt/hdd    192.168.50.0/24(rw,sync,fsid=0,no_subtree_check)
    '';
  };

  systemd.services.nfs-server = {
    after = [ "mnt-hdd.mount" ];
    requires = [ "mnt-hdd.mount" ];
  };

  systemd.services.hd-idle = {
    description = "External HD spin down daemon";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.hd-idle}/bin/hd-idle -i 0 -a /dev/sdb -i 1800";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };

  systemd.services.coolercontrold.environment = {
    CC_HOST_IP4 = "0.0.0.0";
    CC_HOST_IP6 = "::";
  };

  networking.firewall.allowedTCPPorts = [
    11987 # coolercontrol
  ];

  networking.firewall.allowedUDPPorts = [
    53 # dns
  ];

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
