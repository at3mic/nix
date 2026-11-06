# I will generally not be configuring much system-wide packages, so I will not bother
# with seperating them to another file like I did with user-wide packages.
{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    fastfetch
    nixfmt
    keyd
    kdePackages.ksshaskpass
    kdePackages.kate
  ];

  services.keyd = {
    enable = true;

    keyboards.default = {
      ids = [ "*" ];

      # Credits to https://github.com/wleeaf/capslock-nodelay for this fix
      extraConfig = ''
        [global]
        # Never auto-repeat macros: a held Caps Lock key must not re-toggle.
        macro_timeout = 600000

        [main]
        # Emit an instant capslock press+release on key-down, so the stock
        # xkb "unlock happens on key release" delay never applies.
        capslock = macro(capslock)

        # Modifier combos are composite layers in keyd, not `mod+key` bindings.
        [control+shift]
        d = playpause
        s = nextsong
        a = previoussong
      '';
    };
  };
  }
