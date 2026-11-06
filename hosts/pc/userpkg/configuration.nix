{ config, pkgs, inputs, ... }: {
  programs.git = {
    enable = true;
    
    settings = {
      user.name = "at3mic";
      user.email = "295322090+at3mic@users.noreply.github.com";
      safe.directory = "/etc/nixos";
      credential.helper = "store"; # I like being dangerous
    };
  };

  programs.equibop = {
    enable = true;

    equicord.settings = builtins.fromJSON (builtins.readFile ../../../configs/equicord.json);
    settings = builtins.fromJSON (builtins.readFile ../../../configs/equibop.json);
  };

  programs.vscode = {
    enable = true;

    # Fully declarative: extensions are pinned by Nix. Manual installs or
    # updates done inside VS Code will be wiped on the next rebuild.
    mutableExtensionsDir = false;

    profiles.default = {
      userSettings = builtins.fromJSON (builtins.readFile ../../../configs/vscode-user.json);

      extensions = with pkgs.vscode-extensions; [
        alefragnani.project-manager
        golang.go
        jnoortheen.nix-ide
        ms-python.debugpy
        ms-python.python
        ms-python.vscode-pylance
        ms-python.vscode-python-envs
        ms-vsliveshare.vsliveshare
        sainnhe.gruvbox-material
      ] ++ [
        # Not packaged in nixpkgs — built directly from the VS Code Marketplace.
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          publisher = "jonathanharty";
          name = "gruvbox-material-icon-theme";
          version = "1.1.5";
          hash = "sha256-86UWUuWKT6adx4hw4OJw3cSZxWZKLH4uLTO+Ssg75gY=";
        })
      ];
    };
  };

  programs.spicetify = {
    enable = true;

    enabledExtensions = with inputs.spicetify.legacyPackages.${pkgs.system}.extensions; [
      adblockify
    ];
  };
}
