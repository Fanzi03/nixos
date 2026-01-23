{ config, pkgs, ...}: {

	imports = [
		./programs/neovim.nix
		./programs/git.nix
		./programs/bash.nix
		./programs/waybar.nix
		./programs/alacritty.nix
		./programs/hypr/hyprland.nix
		./programs/wofi/wofi.nix
	];


	xdg.enable = true;

	gtk = {
		enable = true;
		iconTheme = { 
			name = "Papirus";
			package = pkgs.papirus-icon-theme;
		};
		theme = {
			name = "Tokyonight";
			package = pkgs.tokyonight-gtk-theme;
		};
		
		#font = {
		#	name = "Jetbrains-mono";
		#	package = pkgs.nerd-fonts.jetbrains-mono;
		#};

	};

        programs.ssh = {
                enable = true;
                #matchBlocks."github.com" ={
                #        identifyFile = "~/.ssh/id_user";
                #};
        };

        programs.direnv = {
                enable = true;
                nix-direnv.enable = true;
        };

	home = { 
		username = "fanzi03";
		homeDirectory = "/home/fanzi03";
		stateVersion = "25.11";



		packages = with pkgs; [

			#discord #blocked
                        #google-chrome
                        transmission_4-gtk
			usbimager
			zapret
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
                        tiled
                        cargo
                        rustc
                        rustfmt
                        clippy
			rust-analyzer
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
