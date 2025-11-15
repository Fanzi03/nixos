{
	description = "My system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ...}@inputs: 
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs{
				inherit system;
				config = {
					allowUnfree = true;
				};
			};
		in
		{
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				specialArgs = {inherit inputs system;};

				modules = [
					./configuration.nix
					inputs.home-manager.nixosModules.home-manager{
						home-manager = {
							useGlobalPkgs = true;
							useUserPackages = true;
							users.fanzi03 = import ./home-manager/home.nix;
							backupFileExtension = "backup";
						};
					}
				];
			};
		};
}
