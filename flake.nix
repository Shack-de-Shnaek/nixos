{
  description = "A simple NixOS flake";

  inputs = {
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

	home-manager = {
	      url = "github:nix-community/home-manager/release-26.05";
	      inputs.nixpkgs.follows = "nixpkgs";
	};

	noctalia = {
	      url = "github:noctalia-dev/noctalia";
	      # inputs.nixpkgs.follows = "nixpkgs"; 
	    };
	noctalia-greeter = {
	  url = "github:noctalia-dev/noctalia-greeter";
	  inputs.nixpkgs.follows = "nixpkgs";
	};
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
nixosConfigurations.dragan-laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix

        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          home-manager.users.dragan = import ./home.nix;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };

    homeConfigurations.dragan-laptop = home-manager.lib.homeManagerConfiguration {
	pkgs = import nixpkgs {
		system = "x86_64-linux";
		config.allowUnfree = true;
	};
      extraSpecialArgs = { inherit inputs; };
      modules = [ ./home.nix ];
    };
  };
}
