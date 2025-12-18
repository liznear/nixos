{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dankMaterialShell.homeModules.default
    inputs.dankMaterialShell.homeModules.niri
  ];

  programs.dankMaterialShell = {
    enable = true;
    enableSystemMonitoring = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;
  };
}
