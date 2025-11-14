{ pkgs, inputs, ... }:

{
  imports = [
    # inputs.vicinae.homeManagerModules.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  # services.vicinae = {
  #   enable = true;
  #   autoStart = true;
  #   settings = {
  #     theme.name = "catppuccin-latte";
  #     font.size = 12;
  #   };
  # };
  programs.dankMaterialShell = {
    enable = true;

    systemd = {
      enable = true;             # Systemd service for auto-start
      restartIfChanged = true;   # Auto-restart dms.service when dankMaterialShell changes
    };
    # niri = {
      # enableKeybinds = true;
      # enableSpawn = true;
    # };

    enableSystemMonitoring = true;     # System monitoring widgets (dgop)
    enableClipboard = true;            # Clipboard history manager
    enableBrightnessControl = true;    # Backlight/brightness controls
    enableDynamicTheming = true;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableSystemSound = true;          # System sound effects
  };
}
