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
    "vivaldi-music.apple.com__-Default" = {
      name = "Apple Music";
      genericName = "Music";
      exec = "vivaldi --app=https://music.apple.com";
      terminal = false;
      categories = [ "Audio" ];
      icon = "/home/nearsyh/.icons/apple_music.svg";
    };
  };
}
