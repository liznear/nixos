{ config, pkgs, inputs, ... }:

{
  xdg.desktopEntries = {
    "vivaldi-chatgpt.com__-Default" = {
      name = "ChatGPT";
      genericName = "AI";
      exec = "vivaldi --app=https://chatgpt.com";
      terminal = false;
      categories = [ "Utility" ];
      icon = "/home/nearsyh/.icons/chatgpt.svg";
    };
  };
}
