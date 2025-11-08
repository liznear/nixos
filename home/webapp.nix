{ config, pkgs, inputs, ... }:

{
  xdg.desktopEntries = {
    chatgpt = {
      name = "ChatGPT";
      genericName = "AI";
      exec = "vivaldi --app=https://chatgpt.com";
      terminal = false;
      categories = [ "Utility" ];
      icon = "/home/nearsyh/.icons/chatgpt.png";
    };
  };
}
