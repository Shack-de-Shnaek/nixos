{ pkgs, ... }:
{
  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
    autoPrune.enable = true;
    autoPrune.allVolumes = {
      enable = true;
      flags = [
        "--volumes"
      ];
    };
  };
}
