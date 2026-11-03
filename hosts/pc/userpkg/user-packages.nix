{ config, inputs, pkgs, ...}: {
  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
    pkgs.equibop
    pkgs.vscode
    pkgs.spotify
    pkgs.spicetify-cli
    pkgs.opencode
  ];
}
