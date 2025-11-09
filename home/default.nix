{ config, pkgs, inputs, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    inputs.noctalia.homeModules.default
    inputs.stylix.homeModules.stylix
    ./rofi
    ./dev.nix
    ./webapp.nix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "/${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
    icons = {
      enable = true;
      package = pkgs.papirus-icon-theme;
      light = "Papirus-Light";
      dark = "Papirus-Dark";
    };
    fonts = {
      serif = {
        package = inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd;
        name = "SFProDisplay Nerd Font";
      };
      sansSerif = {
        package = pkgs.fira-sans;
        name = "Fira Sans";
      };
      monospace = {
        package = pkgs.maple-mono.NF-CN-unhinted;
        name = "Maple Mono NF CN";
      };
    };
  };

  programs.noctalia-shell = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    themeFile = "Catppuccin-Latte";
    settings = {
      font_family = "Maple Mono NF CN";
      hide_window_decorations = "yes";
      enable_audio_bell = "no";
    };
  };

  services.copyq.enable = true;

  home.packages = with pkgs; [
    _1password-gui
    vivaldi
    kitty
    helix
    zed-editor
    obsidian
    htop
    nixd
  ];

  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "kitty";
    TERMINAL = "kitty";
  };

  home.file.".icons" = {
    source = ./resources/icons;
    recursive = true;
  };
  xdg.configFile."niri/config.kdl".source = ./configs/niri/config.kdl;
}
