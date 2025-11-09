{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user.name  = "Liiiz";
      user.email = "liizznear@gmail.com";
      init.defaultBranch = "main";
    };
  };
  programs.zsh = {
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
    };
    shellAliases = {
      ll = "ls -la";
      j = "just";
      za = "zellij attach";
    };
    initContent = ''
function dinit() {
  nix flake init --template "https://flakehub.com/f/the-nix-way/dev-templates/*#$1"
}

export PATH="$HOME/.cargo/bin:$PATH"

export GITHUB_TOKEN=op://Private/GitHub_Liz/token
export OPENROUTER_API_KEY="op://Private/OpenRouter/Saved on openrouter.ai/Marimo"
'';
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
    mise.enable = true;
  };
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      auto_sync = true;
      theme.name = "autumn";
      sync.records = true;
    };
  };
  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-latte";
    };
    enableZshIntegration = false;
  };
  programs.mise = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship.enable = true;
  programs.codex.enable = true;


  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
  };

  home.file.".ssh/config".text = ''
Host *
	IdentityAgent ~/.1password/agent.sock

Host lizgit
  HostName github.com
  User git
  IdentityFile ~/.ssh/liz.pub

Host neargit
  HostName github.com
  User git
  IdentityFile ~/.ssh/near.pub

Host linux-home
  HostName 192.168.2.159
  User nearsyh
  ForwardAgent yes
  IdentityFile ~/.ssh/liz.pub
  SetEnv TERM=xterm-256color
'';

  home.file.".ssh" = {
    source = ./configs/ssh;
    # copy the scripts directory recursively
    recursive = true;
  };
}
