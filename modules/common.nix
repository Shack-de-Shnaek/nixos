{ pkgs, ... }:
{
  # Enable networking
  networking.networkmanager.enable = true;

  boot.supportedFilesystems = [ "nfs" "nfs4" ];

  # Set your time zone.
  time.timeZone = "Europe/Skopje";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_DK.UTF-8";
    LC_IDENTIFICATION = "en_DK.UTF-8";
    LC_MEASUREMENT = "en_DK.UTF-8";
    LC_MONETARY = "en_DK.UTF-8";
    LC_NAME = "en_DK.UTF-8";
    LC_NUMERIC = "en_DK.UTF-8";
    LC_PAPER = "en_DK.UTF-8";
    LC_TELEPHONE = "en_DK.UTF-8";
    LC_TIME = "en_DK.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us,mk";
    variant = "";
  };

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];

    substituters = [
      "https://cache.nixos.org"
      "https://hyprland.cachix.org"
      "https://noctalia.cachix.org"
      "https://cache.nixos-cuda.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-generations +5 --delete-older-than 5d";
  };

  nix.optimise.automatic = true;
  nix.optimise.dates = [ "4:00" ];
  # nix.settings.auto-optimise-store = true;

  users.users."dragan" = {
    isNormalUser = true;
    description = "Dragan Nikolovski";
    extraGroups = [ "networkmanager" "wheel" "video" "docker" ];
    shell = pkgs.fish;
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  services.nfs.server.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    gcc
    zsh
    vim
    git
    ripgrep
    neovim
    rPackages.treesitter
    rPackages.treesitter_r
    rPackages.treesitter_c
    vimPlugins.treesitter-modules-nvim
    neocmakelsp
    tree-sitter
    fzf
    wget
    curl
    btop
    fastfetch
    yazi
    zoxide
    eza
    bat
    greetd
    foot
    nodejs
    python3
    duf
    upower
    smartmontools
    rustup
    nfs-utils
  ];

  programs.fish.enable = true;

  networking.firewall.allowedTCPPorts = [
    2049 # nfs
  ];
}
