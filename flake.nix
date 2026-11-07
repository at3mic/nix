{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    cachy-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    spicetify.url = "github:Gerg-L/spicetify-nix";
    llm-agents = {
      url = "github:numtide/llm-agents.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    helium = {
      url = "github:schembriaiden/helium-browser-nix-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    at3mic = {
      url = "github:at3mic/nixpkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    }
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations.pc = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
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
              inputs.spicetify.homeManagerModules.spicetify
              inputs.plasma-manager.homeModules.plasma-manager
            ];

          _module.args = { inherit inputs; };
          
          };
        }
      ];
    };
  };
}
