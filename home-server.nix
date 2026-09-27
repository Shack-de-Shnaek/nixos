{ config, pkgs, inputs, ... }:

{
  imports = [
  ];

  home.username = "dragan";
  home.homeDirectory = "/home/dragan";
  home.stateVersion = "26.05";

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "vivaldi";
    FILE_MANAGER = "yazi";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      cd = "z";
      cat = "bat";
      ls = "eza";
      grep = "rg";
    };
  };

  programs.zoxide = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Dragan Nikolovski";
    };
    extraConfig = {
      safe.directory = [
        "/etc/nixos/"
      ];
    };
  };

  programs.foot = {
    enable = true;
    server.enable = true;
    settings.colors-dark = {
      alpha = 0.7;
      blur = true;
    };
    settings.colors-light = {
      alpha = 0.7;
      blur = true;
    };

  };

  programs.tmux = {
    enable = true;
  };

  programs.claude-code = {
    enable = true;
  };

  home.packages = with pkgs; [
    home-manager
    eza
    zoxide
    jq
    killall
    lazygit
    qdiskinfo
    playerctl
    alsa-utils
  ];

  xdg.configFile."nvim".source = ./dotfiles/nvim;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/slack" = [ "slack.desktop" ];
      "x-scheme-handler/claude-cli" = [ "claude-code-url-handler.desktop" ];
    };
  };
}
