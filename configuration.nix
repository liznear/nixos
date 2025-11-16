# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ pkgs, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-lap";
  networking.networkmanager.enable = true;
  networking.hosts = {
    "185.199.108.133" = [ "raw.githubusercontent.com" ];
    "172.64.155.209" = [ "chatgpt.com" ];
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
    vulkan-tools
  ];

  fonts = {
    packages = with pkgs; [
      maple-mono.NF-CN-unhinted
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      inputs.apple-fonts.packages.${pkgs.stdenv.hostPlatform.system}.sf-pro-nerd
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
  programs.nix-ld.enable = true;

  services.fprintd.enable = true;
  services.xserver.videoDrivers = [ "modesetting" ];
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
    mouse = {
      accelProfile = "flat";
      accelSpeed = 0.08;
    };
  };

  virtualisation = {
    containers.enable = true;
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  users.users.nearsyh = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "podman" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [ ];
    shell = pkgs.zsh;
  };
  security.sudo.extraConfig = ''
  Defaults env_keep += "NIX_CONFIG"
  '';

  powerManagement.enable = true;
  boot.kernelParams = [ "resume_offset=38912" "mem_sleep_default=s2idle" "i915.enable_dc=2" "i915.enable_psr=1" ];
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
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "nearsyh";
      };
    };
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
    extra-substituters = [ "https://vicinae.cachix.org" ];
    extra-trusted-public-keys = [ "vicinae.cachix.org-1:1kDrfienkGHPYbkpNj1mWTr7Fm1+zcenzgTizIcI3oc=" ];
  };
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05"; # Did you read the comment?

}
