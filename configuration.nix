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
  networking.hosts = {
    "185.199.108.133" = [ "raw.githubusercontent.com" ];
  };

  time.timeZone = "Asia/Shanghai";


  i18n = {
    supportedLocales = [ "en_US.UTF-8/UTF-8" "zh_CN.UTF-8/UTF-8" ];
  };
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      catppuccin-fcitx5
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
      inputs.apple-fonts.packages.${pkgs.system}.sf-pro-nerd
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
  services.thermald.enable = true;
  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
         governor = "powersave";
         turbo = "never";
         enable_thresholds = true;
         start_threshold = 60;
         stop_threshold = 80;
      };
      charger = {
         governor = "performance";
         turbo = "auto";
      };
    };
  };
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      accelSpeed = "-0.5";
    };
  };

  users.users.nearsyh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };

  powerManagement.enable = true;
  boot.kernelParams = [ "resume_offset=38912" "mem_sleep_default=deep" ];
  boot.resumeDevice = "/dev/disk/by-uuid/050a2230-5bc9-4e1e-8ff2-e3b142515427";
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024; # 32GB
    }
  ];
  services.logind.settings.Login = {
    HandleLidSwitch = "suspend-then-hibernate";
    HandlePowerKey = "hibernate";
    HandlePowerKeyLongPress = "poweroff";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30m
    SuspendState=mem
  '';

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
