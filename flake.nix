{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
        url = "github:schembriaiden/helium-browser-nix-flake";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/pc/configuration.nix
	home-manager.nixosModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.at3mic.home.stateVersion = "26.05";
          home-manager.users.at3mic = {
            imports = [
              ./hosts/pc/userpkg/configuration.nix
              ./hosts/pc/userpkg/user-packages.nix
            ];

            _module.args = { inherit inputs; };
          };
        }
      ];
    };
  };
}
