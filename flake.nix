{
	description = "My system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.05";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { self, nixpkgs, home-manager, ...}: {
			system = "x86_64-linux";
			nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
				modules = [
					./configuration.nix
					home-manager.nixosModules.home-manager
				#./home.nix
				];
			};
		};
}
