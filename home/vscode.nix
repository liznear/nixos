{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      userSettings = lib.mkForce {
        "chat.disableAIFeatures" = true;
        "chat.editor.fontFamily" = "Maple Mono NF CN";
        "chat.editor.fontSize" = 15.0;
        "debug.console.fontFamily" = "Maple Mono NF CN";
        "debug.console.fontSize" = 15.0;
        "editor.fontFamily" = "Maple Mono NF CN";
        "editor.fontSize" = 15.0;
        "editor.inlayHints.fontFamily" = "Maple Mono NF CN";
        "editor.inlineSuggest.fontFamily" = "Maple Mono NF CN";
        "editor.minimap.sectionHeaderFontSize" = 11;
        "markdown.preview.fontFamily" = "Fira Sans";
        "markdown.preview.fontSize" = 15.0;
        "scm.inputFontFamily" = "Maple Mono NF CN";
        "scm.inputFontSize" = 15;
        "screencastMode.fontSize" = 64.0;
        "terminal.integrated.fontSize" = 15.0;
        "workbench.colorTheme" = "Stylix";
      };
      extensions = with pkgs.vscode-extensions; [
        ms-toolsai.jupyter
        ms-python.python
        mkhl.direnv
        catppuccin.catppuccin-vsc
        catppuccin.catppuccin-vsc-icons
        vscodevim.vim
      ];
    };
  };
}
