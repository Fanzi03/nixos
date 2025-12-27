{
	description = "My system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
		nvf.url = "github:notashelf/nvf";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, nvf, ...}@inputs: 
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
			packages.${system}.default = 
			(nvf.lib.neovimConfiguration {
				inherit pkgs;
				modules = [ ./home-manager/programs/nvf.nix ];
			}).neovim;

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

                                        nvf.nixosModules.default
				];
			};
		};
}
