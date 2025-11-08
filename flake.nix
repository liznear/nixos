{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    apple-fonts.url= "github:Lyndeno/apple-fonts.nix";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, stylix, ... }: {
    nixosConfigurations."nixos-lap" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            extraSpecialArgs = { inherit inputs; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.nearsyh = import ./home;
            backupFileExtension = "backup";
          };
        }
      ];
    };
  };
}

