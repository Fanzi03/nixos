{ config, pkgs, ...}: {

	imports = [
		./programs/neovim.nix
		./programs/git.nix
		./programs/bash.nix
		./programs/waybar.nix
		./programs/alacritty.nix
		#		./programs/hyprland.nix
	];

	home = { 
		username = "fanzi03";
		homeDirectory = "/home/fanzi03";
		stateVersion = "25.05";



		packages = with pkgs; [

			#discord #blocked
			google-chrome
			nwg-look
			fastfetch
			cmatrix
			fd
			duf
			blender
			jetbrains-mono
			alacritty
			pavucontrol
			timer
			libnotify
			mako
			haskellPackages.pulseaudio
			libreoffice-qt6-fresh
			telegram-desktop
			vscode-langservers-extracted
			emmet-ls
			nodePackages.typescript
			nodejs_24
			nodePackages.typescript-language-server

			gitui
			jq
			python313Packages.xmljson
			waybar
			xorg.libX11 
			xorg.libXrender
			xorg.libXtst 
			gtk3 
			glib
			openjfx21
		];
	};
}
