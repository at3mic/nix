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

  # Desktop theming: stock Breeze Dark base, the "Vencord" color scheme
  # (Gruvbox Material palette, scheme file lives in configs/), a custom
  # Gruvbox-green accent, and the wallhaven wallpaper.
  programs.plasma = {
    enable = true;

    workspace = {
      lookAndFeel = "org.kde.breezedark.desktop";
      colorScheme = "Vencord";
      wallpaper = ../../../configs/wallhaven-wyv9qx.jpg;
    };

    # plasma-apply-colorscheme (priority 1) resets the custom accent, so
    # re-write it after the themes, before the wallpaper scripts (priority 3).
    startup.startupScript."accent-color" = {
      priority = 2;
      text = ''
        kwriteconfig6 --file kdeglobals --group KDE --key AccentColor 168,182,101
        kwriteconfig6 --file kdeglobals --group KDE --key LastUsedCustomAccentColor 168,182,101
        kwriteconfig6 --file kdeglobals --group General --key LastUsedCustomAccentColor 168,182,101
      '';
    };
  };

  xdg.dataFile."color-schemes/Vencord.colors".source = ../../../configs/Vencord.colors;

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
