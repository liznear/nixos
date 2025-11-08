# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-lap"; # Define your hostname.
  networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  time.timeZone = "Asia/Shanghai";

  powerManagement.enable = true;

  i18n = {
    supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
    ];
    fcitx5.waylandFrontend = true;
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    inputs.noctalia.packages.${system}.default
  ];

  fonts = {
    packages = with pkgs; [
      maple-mono.NF-CN-unhinted
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Noto Sans CJK SC" ];
        serif = [ "Noto Serif CJK SC" ];
        monospace = [ "Maple Mono NF CN" ];
      };
    };
  };

  programs.niri.enable = true;
  programs.zsh.enable = true;

  services.openssh.enable = true;
  services.upower.enable = true;

  users.users.nearsyh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store?priority=10"
      "https://mirrors.ustc.edu.cn/nix-channels/store?priority=5"
      "https://cache.nixos.org/"
    ];
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}

