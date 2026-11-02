{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    fastfetch
    kdePackages.ksshaskpass
    nixfmt
  ];
}
