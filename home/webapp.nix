{ config, pkgs, inputs, ... }:

{
  xdg.desktopEntries = {
    "google-chrome-stable-chatgpt.com__-Default" = {
      name = "ChatGPT";
      genericName = "AI";
      exec = "google-chrome-stable --app=https://chatgpt.com";
      terminal = false;
      categories = [ "Utility" ];
      icon = "/home/nearsyh/.icons/chatgpt.svg";
    };
    "google-chrome-stable-music.youtube.com__-Default" = {
      name = "Youtube Music";
      genericName = "Music";
      exec = "google-chrome-stable --app=https://music.youtube.com";
      terminal = false;
      categories = [ "Audio" ];
      icon = "/home/nearsyh/.icons/youtube_music.svg";
    };
  };
}
