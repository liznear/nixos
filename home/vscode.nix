{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = {
        "chat.disableAIFeatures" = true;
      };
      extensions = with pkgs.vscode-extensions; [
        ms-toolsai.jupyter
        ms-python.python
        mkhl.direnv
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
      ];
    };
  };
}
