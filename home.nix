{ config, pkgs, ... }:

{

  home.username = "nearsyh";
  home.homeDirectory = "/home/nearsyh";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName  = "Liiiz";
    userEmail = "liizznear@gmail.com";
  };
  programs.zsh = {
    enable = true;
  };

  home.packages = with pkgs; [
    _1password-gui
    vivaldi
    ghostty
    fuzzel
  ];
  
  home.sessionVariables = {
    XDG_SESSION_TYPE = "wayland";
    GTK_IM_MODULE = "ibus";
    QT_IM_MODULE = "ibus";
    XMODIFIERS = "@im=ibus";
    
  };
  
  xdg.configFile."niri/config.kdl".source = ./configs/niri/config.kdl;

}
