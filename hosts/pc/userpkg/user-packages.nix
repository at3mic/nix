{ config, inputs, pkgs, ...}: {
  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
    pkgs.equibop
    pkgs.vscode
  ];
}
