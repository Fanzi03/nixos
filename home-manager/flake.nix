{
	description = "Home-manager configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = {nixpkgs, home-manager, ...}: 
		let
			system = "x86_64-linux";
			pkgs = nixpkgs.legacyPackages.${system};
		in{
			homeConfigurations = {
				fanzi03 = home-manager.lib.homeManagerConfiguration{
					inherit pkgs;

					modules = [ ./home.nix ];
				};	
			};

		};
}

