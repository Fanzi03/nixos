{
	description = "Home-manager configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
		nixpkgs-old.url = "github:nixos/nixpkgs/nixos-25.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-26.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {nixpkgs, nixpkgs-old ,home-manager, ...}: 
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
      pkgs-old = nixpkgs-old.legacyPackages.${system};
		in{
			homeConfigurations = {
				fanzi03 = home-manager.lib.homeManagerConfiguration{
					inherit pkgs;
          extraSpecialArgs = {inherit pkgs-old;};

					modules = [ ./home.nix  ];
				};	
			};

		};
}

