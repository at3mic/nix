{ config, inputs, pkgs, ...}: {
  home.packages = [
    inputs.at3mic.packages.${pkgs.system}.sklauncher4
    inputs.helium.packages.${pkgs.system}.default
    inputs.llm-agents.packages.${pkgs.system}.opencode2
    pkgs.equibop
    pkgs.vscode
    (pkgs.steam.override {
      extraEnv.STEAM_EXTRA_COMPAT_TOOLS_PATHS =
        "${inputs.powerofthe69.packages.${pkgs.system}.proton-cachyos-x86_64-v3.steamcompattool}";
    })
  ];
}
