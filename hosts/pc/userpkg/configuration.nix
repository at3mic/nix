{ config, pkgs, ... }: {
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "at3mic";
      user.email = "295322090+at3mic@users.noreply.github.com";
    };
  };

  programs.equibop = {
    enable = true;
  };

  programs.vscode = {
    enable = true;

    mutableExtensionsDir = true;
    profiles.default.userSettings = builtins.fromJSON (builtins.readFile ../../../configs/vscode-user.json);
  };
}
