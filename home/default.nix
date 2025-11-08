{ config, pkgs, inputs, ... }:

{
  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";

  imports = [
    inputs.noctalia.homeModules.default
    ./shell.nix
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name  = "Liiiz";
      user.email = "liizznear@gmail.com";
      init.defaultBranch = "main";
    }; 
  };
  programs.noctalia-shell = {
    enable = true;
  };
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "Maple Mono NF CN";
      hide_window_decorations = "yes";
      enable_audio_bell = "no";
    };
  };

  home.packages = with pkgs; [
    _1password-gui
    vivaldi
    kitty
    fuzzel
  ];
  
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    GDK_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    TERM = "kitty";
    TERMINAL = "kitty";
  };
  
  xdg.configFile."niri/config.kdl".source = ./configs/niri/config.kdl;
}
