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
    "vivaldi-music.youtube.com__-Default" = {
      name = "Youtube Music";
      genericName = "Music";
      exec = "vivaldi --app=https://music.youtube.com";
      terminal = false;
      categories = [ "Audio" ];
      icon = "/home/nearsyh/.icons/youtube_music.svg";
    };
  };
}
