{ config, pkgs, ...}: {

	imports = [
		./programs/neovim.nix
		./programs/git.nix
		./programs/bash.nix
#		./programs/waybar.nix
		./programs/alacritty.nix
#		./programs/hypr/hyprland.nix
#		./programs/wofi/wofi.nix
	];

	home = { 
		username = "btw";
		homeDirectory = "/home/btw";
		stateVersion = "25.05";



		packages = with pkgs; [

			#discord #blocked
			#google-chrome
			#rustc
			#cargo
			xclip #for x11
			fd
			duf
			jetbrains-mono
			alacritty
			pavucontrol
			timer
			libnotify
			mako
			haskellPackages.pulseaudio
			vscode-langservers-extracted
			emmet-ls
			nodePackages.typescript
			nodejs_24
			nodePackages.typescript-language-server

			gitui
			jq
			glib
		];
	};
}
