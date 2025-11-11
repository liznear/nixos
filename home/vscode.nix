{ config, pkgs, lib, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
       userSettings = {
       };
       extensions = with pkgs; [
       ];
    };
  };
}
