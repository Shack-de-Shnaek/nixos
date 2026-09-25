{ pkgs, ... }:
{
  powerManagement.powertop.enable = true;
  services.thermald.enable = true;
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}

