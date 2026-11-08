# I will generally not be configuring much system-wide packages, so I will not bother
# with seperating them to another file like I did with user-wide packages.
{ pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    wget
    fastfetch
    nixfmt
    keyd
    pciutils
    kdePackages.ksshaskpass
    kdePackages.kate

    xorg.libX11
    xorg.libXext
    xorg.libXrender
    xorg.libXrandr
    xorg.libXi
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXxf86vm
    libxcb
  ];

  programs.nix-ld.enable = true;

  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    libx11
    libxext
    libxrender
    libxrandr
    libxi
    libxcursor
    libxinerama
    libxxf86vm
    libxcb
    libxkbcommon
    wayland
    mesa
    alsa-lib
    libpulseaudio
  ];

  environment.sessionVariables.LD_LIBRARY_PATH = [
    "/run/opengl-driver/lib"
    "/run/opengl-driver-32/lib"
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
