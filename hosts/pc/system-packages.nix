{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    fastfetch
    nixfmt
    kdePackages.ksshaskpass
    kdePackages.kate
  ];
}
