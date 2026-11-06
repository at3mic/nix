{ config, pkgs, inputs, ... }: {
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "at3mic";
      user.email = "295322090+at3mic@users.noreply.github.com";
      safe.directory = "/etc/nixos";
    };
  };

  programs.equibop = {
    enable = true;

    equicord.settings = builtins.fromJSON (builtins.readFile ../../../configs/equicord.json);
    settings = builtins.fromJSON (builtins.readFile ../../../configs/equibop.json);
  };

  programs.vscode = {
    enable = true;

    mutableExtensionsDir = true;
    profiles.default.userSettings = builtins.fromJSON (builtins.readFile ../../../configs/vscode-user.json);
  };

  programs.spicetify = {
    enable = true;

    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.system}.extensions; [
      adblockify
    ];
  };
}
