{ config, inputs, pkgs, ...}: {
  home.packages = [
    inputs.helium.packages.${pkgs.system}.default
    inputs.llm-agents.packages.${pkgs.system}.opencode2
    pkgs.equibop
    pkgs.vscode
  ];
}
