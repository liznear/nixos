{ config, pkgs, lib, ... }:

let 
  secrets = import ./secrets.nix {};
in
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
export GOOGLE_CLOUD_PROJECT_ID=gen-lang-client-0560206947

source ~/.config/.credentials
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

  programs.codex = {
    enable = true;
  };
  programs.gemini-cli = {
    enable = true;
  };
  programs.crush = {
    enable = true;
    settings = {
      providers = {
        openai = {
          id = "openai";
          name = "OpenAI";
          base_url = "http://192.168.2.178:8000/v1";
          type = "openai";
          api_key = "sk-fake";
          models = [
            {
              id = "gpt-5.1-codex";
              name = "GPT 5.1 Codex";
            }
          ];
        };
      };
      lsp = {
        go = { command = "gopls"; enabled = true; };
        nix = { command = "nil"; enabled = true; };
        rust = { command = "rust-analyzer"; enabled = true; };
      };
      mcp = {
        chrome-devtools = {
           command = "npx";
           args = [ "chrome-devtools-mcp@latest" ];
        };
      };
    };
  };

  programs.zed-editor = {
    enable = true;
    settings = {
      base_keymap = "JetBrains";
      context_servers = {
        chrome-devtools = {
          enabled = true;
          command = "npx";
          args = [ "chrome-devtools-mcp@latest" ];
        };
        mcp-server-exa-search = {
          enabled = true;
          settings = {
            exa_api_key = secrets.apikey.exa;
          };
        };
        mcp-server-context7 = {
          enabled = true;
          settings = {
            context7_api_key = secrets.apikey.context7;
          };
        };
      };
      autosave = {
        after_delay = {
          milliseconds = 1000;
        };
      };
      ui_font_family = "Fira Sans";
      buffer_font_family = "Maple Mono NF CN";
      vim_mode = true;
      ui_font_size = 16.0;
      buffer_font_size = 16.0;
      theme = "Base16 Catppuccin Latte";
    };
  };

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
