{ ... }:

{
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
        go = {
          command = "gopls";
          enabled = true;
        };
        nix = {
          command = "nil";
          enabled = true;
        };
        rust = {
          command = "rust-analyzer";
          enabled = true;
        };
      };
      mcp = {
        chrome-devtools = {
          command = "npx";
          args = [ "chrome-devtools-mcp@latest" ];
        };
      };
    };
  };
  programs.opencode = {
    enable = true;
    settings = {
      plugin = [ "opencode-openai-codex-auth@4.0.2" ];
      mcp = {
        chrome-devtools = {
          type = "local";
          command = [
            "npx"
            "chrome-devtools-mcp@latest"
          ];
          enabled = true;
        };
      };
      provider = {
        openai = {
          options = {
            reasoningEffort = "medium";
            reasoningSummary = "auto";
            textVerbosity = "medium";
            include = [ "reasoning.encrypted_content" ];
            store = false;
          };
          models = {
            "gpt-5.1-codex-medium" = {
              name = "GPT 5.1 Codex Medium (OAuth)";
              limit = {
                context = 272000;
                output = 128000;
              };
              options = {
                reasoningEffort = "medium";
                reasoningSummary = "auto";
                textVerbosity = "medium";
                include = [ "reasoning.encrypted_content" ];
                store = false;
              };
            };
            "gpt-5.1-codex-high" = {
              name = "GPT 5.1 Codex High (OAuth)";
              limit = {
                context = 272000;
                output = 128000;
              };
              options = {
                reasoningEffort = "high";
                reasoningSummary = "detailed";
                textVerbosity = "medium";
                include = [ "reasoning.encrypted_content" ];
                store = false;
              };
            };
          };
        };
      };
    };
  };
}
