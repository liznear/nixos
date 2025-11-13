{ pkgs, inputs, ... }:

{
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    autoStart = true;
    settings = {
      theme.name = "catppuccin-latte";
      font.size = 12;
    };
  };
}